import 'dart:ui' as ui;
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting
import '../models/maintenance_component_model.dart'; // Needed for component reference

class MaintenanceProgressPainter extends CustomPainter {
  final bool isMileageType;
  final double currentValue; // Current total mileage or elapsed days since last maintenance
  final double vehicleCurrentMileage; // ACTUAL current vehicle mileage, regardless of type
  final double? targetValue; // Target mileage (can be null)
  final double cycleValue; // Cycle mileage or days
  final String unit; // 'km' or 'days'
  final Color statusColor;
  final DateTime? targetDate;
  final DateTime? lastMaintenanceDate; // Needed for date calculations
  final MaintenanceComponent component; // Pass component for easier access to related fields

  // Thresholds (copied from carsave_app logic)
  static const double mileageAttentionThreshold = 100.0;
  static const double dateAttentionThreshold = 10.0; // days

  MaintenanceProgressPainter({
    required this.component, // Require component
    required this.isMileageType,
    required this.currentValue, // This is either vehicle mileage or days passed
    required this.vehicleCurrentMileage, // Pass the actual vehicle mileage here
    this.targetValue, // From component.targetMaintenanceMileage
    required this.cycleValue, // From component.maintenanceValue
    required this.unit, // From component.unit
    required this.statusColor,
    this.targetDate, // From component.targetMaintenanceDate
    this.lastMaintenanceDate, // From component.lastMaintenance
  });

  // Helper to format numbers (from carsave_app)
  String formatNumber(double number) {
    if (number >= 10000) {
      return '${(number / 10000).toStringAsFixed(1)}w';
    } else if (number >= 1000) {
        // Keep integer format for thousands to avoid ".0k"
        return '${(number / 1000).toStringAsFixed(number % 1000 == 0 ? 0 : 1)}k';
    }
    return number.toStringAsFixed(0); // Keep as integer if below 1000
  }
  
  // 添加：计算并格式化时间间隔为年月日的辅助方法
  String formatTimeSpan(DateTime startDate, DateTime endDate) {
    // 确保开始日期早于结束日期
    if (startDate.isAfter(endDate)) {
      final temp = startDate;
      startDate = endDate;
      endDate = temp;
    }
    
    // 计算总天数差
    final differenceInDays = endDate.difference(startDate).inDays;
    
    // 计算年数、月数和天数
    int years = 0;
    int months = 0;
    int days = 0;
    
    // 临时日期，用于计算
    DateTime tempDate = DateTime(startDate.year, startDate.month, startDate.day);
    
    // 计算年数
    while (tempDate.year < endDate.year || 
          (tempDate.year == endDate.year && tempDate.month <= endDate.month && tempDate.day <= endDate.day)) {
      years++;
      tempDate = DateTime(tempDate.year + 1, tempDate.month, tempDate.day);
      
      // 确保不超过结束日期
      if (tempDate.isAfter(endDate)) {
        years--;
        tempDate = DateTime(tempDate.year - 1, tempDate.month, tempDate.day);
        break;
      }
    }
    
    // 计算月数
    while (tempDate.month < endDate.month || 
          (tempDate.month == endDate.month && tempDate.day <= endDate.day)) {
      months++;
      
      // 处理月份进位
      int newMonth = tempDate.month + 1;
      int newYear = tempDate.year;
      if (newMonth > 12) {
        newMonth = 1;
        newYear++;
      }
      
      // 处理月末日期问题（如2月30日不存在的情况）
      int newDay = tempDate.day;
      int lastDayOfMonth = DateTime(newYear, newMonth + 1, 0).day;
      if (newDay > lastDayOfMonth) {
        newDay = lastDayOfMonth;
      }
      
      tempDate = DateTime(newYear, newMonth, newDay);
      
      // 确保不超过结束日期
      if (tempDate.isAfter(endDate)) {
        months--;
        // 重置tempDate
        newMonth = tempDate.month - 1;
        newYear = tempDate.year;
        if (newMonth < 1) {
          newMonth = 12;
          newYear--;
        }
        lastDayOfMonth = DateTime(newYear, newMonth + 1, 0).day;
        newDay = tempDate.day > lastDayOfMonth ? lastDayOfMonth : tempDate.day;
        tempDate = DateTime(newYear, newMonth, newDay);
        break;
      }
    }
    
    // 计算剩余天数
    days = endDate.difference(tempDate).inDays;
    
    // 构建显示字符串
    String result = '';
    if (years > 0) {
      result += '$years年';
    }
    if (months > 0 || years > 0) {
      result += '$months月';
    }
    result += '$days日';
    
    return result.isEmpty ? '0日' : result; // 确保至少显示"0日"
  }

  @override
  void paint(Canvas canvas, Size size) {
    // print("Painter Args: isMileage=$isMileageType, current=$currentValue, vehicleCurrent=$vehicleCurrentMileage, target=$targetValue, cycle=$cycleValue, unit=$unit, lastDate=$lastMaintenanceDate, targetDate=$targetDate");

    final double strokeWidth = 3.0;
    final double topCurveHeight = size.height * 0.5;
    final double bottomCurveHeight = size.height * 0.25;
    final double textOffsetY = 3; // Offset for text below curves
    final double labelOffsetY = 5; // Offset for labels above curves

    // Define specific gaps for labels/values
    final double topLabelGap = 20.0; // Increased gap above top curve for labels
    final double topValueGap = 8.0;  // Gap above top curve for values (closer than labels)
    final double bottomLabelGap = 8.0; // Gap below bottom curve for labels
    final double bottomValueGap = 20.0; // Increased gap below bottom curve for values

    final Paint baselinePaint = Paint()
      ..color = Colors.grey[400]!
      ..strokeWidth = 1.0 // Thin baseline
      ..style = PaintingStyle.stroke;

    // --- Draw Baseline --- START
    final Offset startPointBaseline = Offset(0, size.height / 2);
    final Offset endPointBaseline = Offset(size.width, size.height / 2);
    canvas.drawLine(startPointBaseline, endPointBaseline, baselinePaint);
    // --- Draw Baseline --- END

    final Paint bottomCurvePaint = Paint() // Target/Cycle range curve
      ..color = Colors.amber[300]! // Use a distinct color for the target range
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // --- Define specific paints for top curve segments --- START
    final Paint orangePaint = Paint()
      ..color = Colors.orange
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.butt;

    final Paint redPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.butt;
    // --- Define specific paints for top curve segments --- END

    // --- Calculate Progress Ratio ---
    double progressRatio = 0.0; // Percentage of the cycle completed (0.0 to 1.0+)
    double cycleStartValue = 0.0; // The starting point of the current cycle (mileage or date epoch)
    double cycleEndValue = 0.0; // The target point of the current cycle (mileage or date epoch)
    double actualCurrentValue = 0.0; // The current value (mileage or date epoch) to compare against the cycle
    double drivenMileageInCycle = 0.0; // Declare with wider scope, initialize

    DateTime now = DateTime.now();
    DateTime startOfToday = DateTime(now.year, now.month, now.day);

    if (isMileageType) {
        // Use vehicleCurrentMileage for calculations
        actualCurrentValue = vehicleCurrentMileage;
        // Determine the end of the current cycle (Target Mileage)
        cycleEndValue = targetValue ?? 0; // Use targetValue directly, default to 0 if null

        // Calculate the approximate start of the current cycle
        double cycleStartMileage = (targetValue != null && targetValue! > cycleValue) 
                                   ? targetValue! - cycleValue 
                                   : 0; // Fallback if target is invalid or not set
        
        // Calculate mileage driven within the current cycle
        // Calculate this *before* calculating progressRatio
        // Assign to the variable declared outside the block
        drivenMileageInCycle = (vehicleCurrentMileage - cycleStartMileage).clamp(0.0, cycleValue * 1.5); 

        // --- Calculate Progress Ratio based on cycle length --- 
        if (cycleValue > 0) {
            // 修改：改为计算当前里程与目标里程的比例
            if (cycleEndValue > 0) {
                // 直接计算当前里程占目标里程的比例
                progressRatio = (actualCurrentValue / cycleEndValue).clamp(0.0, 1.0);
            } else {
                progressRatio = 0.0; // 目标里程为0，进度为0
            }
        } else {
            progressRatio = 0.0; // Cycle is 0, progress is 0
        }
        
    } else { // Date Type
        DateTime effectiveLastDate = lastMaintenanceDate ?? DateTime(1970); // Use epoch if null
        DateTime effectiveTargetDate = targetDate ?? effectiveLastDate.add(Duration(days: cycleValue.toInt()));

        // Use days since epoch for calculations to handle potential inconsistencies
        actualCurrentValue = startOfToday.difference(DateTime(1970)).inDays.toDouble();
        cycleStartValue = effectiveLastDate.difference(DateTime(1970)).inDays.toDouble();
        cycleEndValue = effectiveTargetDate.difference(DateTime(1970)).inDays.toDouble();

        // Ensure cycleEnd is after cycleStart
        if (cycleEndValue <= cycleStartValue) {
           cycleEndValue = cycleStartValue + 1; // Ensure positive duration
        }

        progressRatio = ((actualCurrentValue - cycleStartValue) / (cycleEndValue - cycleStartValue)).clamp(0.0, 1.5); // Allow overshoot
    }

    // print("Calculated: Start=$cycleStartValue, End=$cycleEndValue, Current=$actualCurrentValue, Ratio=$progressRatio");


    // --- Draw Curves ---
    final Path bottomPath = Path();
    bottomPath.moveTo(0, size.height / 2);
    bottomPath.quadraticBezierTo(
        size.width / 2, size.height / 2 + bottomCurveHeight, // Control point below
        size.width, size.height / 2);
    canvas.drawPath(bottomPath, bottomCurvePaint);

    final Path topPathFull = Path();
    topPathFull.moveTo(0, size.height / 2);
    topPathFull.quadraticBezierTo(
        size.width / 2, size.height / 2 - topCurveHeight, // Control point above
        size.width, size.height / 2);

    // Calculate the split point for the top curve based on progressRatio
    // Need to find the (x, y) coordinates on the quadratic Bezier curve for a given t (progressRatio)
    final Offset p0 = Offset(0, size.height / 2); // Start point
    final Offset p1 = Offset(size.width / 2, size.height / 2 - topCurveHeight); // Control point
    final Offset p2 = Offset(size.width, size.height / 2); // End point

    // Clamp ratio for drawing top curve parts to avoid visual errors
    double clampedRatio = progressRatio.clamp(0.0, 1.0);
    
    // 修改：应用最小显示比例规则（确保每部分至少有10%的显示宽度）
    if (clampedRatio < 0.1) {
        // 如果进度小于10%，将其设为10%的最小显示宽度
        clampedRatio = 0.1;
    } else if (clampedRatio > 0.9) {
        // 如果剩余比例小于10%，将进度设为90%，确保剩余部分有10%
        clampedRatio = 0.9;
    }

    // Calculate split point coordinates
    double splitX = math.pow(1 - clampedRatio, 2) * p0.dx + 2 * (1 - clampedRatio) * clampedRatio * p1.dx + math.pow(clampedRatio, 2) * p2.dx;
    double splitY = math.pow(1 - clampedRatio, 2) * p0.dy + 2 * (1 - clampedRatio) * clampedRatio * p1.dy + math.pow(clampedRatio, 2) * p2.dy;
    Offset splitPoint = Offset(splitX, splitY);

    // --- DRAW TOP CURVE AS TWO SEGMENTS --- START
    final double controlY = size.height / 2 - topCurveHeight;
    final double startAndEndY = size.height / 2;
    // final double valleyDepth = 5.0; // REVERT: Remove valley depth
    // final double connectionY = startAndEndY + valleyDepth; // REVERT: Remove connection point below baseline

    // Draw Progress Segment (if any)
    if (clampedRatio > 0) {
        final Path progressPath = Path();
        progressPath.moveTo(0, startAndEndY); // Start on baseline
        final double controlX1 = splitX * 0.75; // Keep adjusted control point
        progressPath.quadraticBezierTo(
            controlX1, controlY,
            splitX, startAndEndY); // REVERT: End back on baseline
        canvas.drawPath(progressPath, orangePaint); // Use orange paint
    }

    // Draw Remaining Segment (if any)
    if (clampedRatio < 1.0) {
        final Path remainingPath = Path();
        remainingPath.moveTo(splitX, startAndEndY); // REVERT: Start back on baseline
        final double controlX2 = splitX + (size.width - splitX) * 0.25; // Keep adjusted control point
        remainingPath.quadraticBezierTo(
            controlX2, controlY,
            size.width, startAndEndY); // End on baseline at full width
        canvas.drawPath(remainingPath, redPaint); // Use red paint
    }
    // --- DRAW TOP CURVE AS TWO SEGMENTS --- END


    // --- Draw Text Labels ---
    final TextPainter textPainter = TextPainter(
      textDirection: ui.TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    // Function to draw text centered horizontally
    void drawText(String text, Offset centerOffset, double maxWidth, {Color color = Colors.black, double fontSize = 11.0, FontWeight fontWeight = FontWeight.normal}) {
      textPainter.text = TextSpan(
        text: text,
        style: TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight),
      );
      textPainter.layout(minWidth: 0, maxWidth: maxWidth);
      // Adjust offset to center the text block horizontally
      final Offset centeredDrawOffset = Offset(centerOffset.dx - textPainter.width / 2, centerOffset.dy);
      textPainter.paint(canvas, centeredDrawOffset);
    }

    // Values for labels
    String drivenText, targetText, cycleText, remainingText, cycleAndRemainingText;
    double remainingValue = 0;

    // Combine label, value, and unit
    if (isMileageType) {
      // Correct drivenText to show TOTAL vehicle mileage as requested
      drivenText = '行驶里程: ${formatNumber(actualCurrentValue)} km'; // Use actualCurrentValue (total mileage for mileage type)
      targetText = '目标里程: ${formatNumber(cycleEndValue)} km'; // Combine label+value+unit
      String cycleValueStr = '${formatNumber(cycleValue)} km'; // Value+unit for cycle
      remainingValue = cycleEndValue - actualCurrentValue;
      String remainingValueStr = remainingValue >= 0
          ? '${formatNumber(remainingValue.abs())} km' // Value+unit for remaining
          : '已超出: ${formatNumber(remainingValue.abs())} km'; // Include '超出' if negative
      remainingText = remainingValue >= 0 ? '剩余: $remainingValueStr' : remainingValueStr; // Label + value string for remaining part
      cycleAndRemainingText = '保养周期: $cycleValueStr, ${remainingValue >= 0 ? "剩余" : ""}: $remainingValueStr'; // Combine cycle and remaining

    } else { // Date Type
      // 修改：显示行驶天数而不是当前日期
      final DateTime lastDate = lastMaintenanceDate ?? DateTime.now();
      final String timeSpan = formatTimeSpan(lastDate, startOfToday);
      drivenText = '行驶天数: $timeSpan'; // 改为显示行驶天数
      
      targetText = '目标日期: ${DateFormat('yy-MM-dd').format(DateTime(1970).add(Duration(days: cycleEndValue.toInt())))}'; // Combine label+value
      String cycleValueStr = '${cycleValue.toInt()}天'; // Value+unit for cycle
      remainingValue = cycleEndValue - actualCurrentValue; // Remaining days (can be negative)
      String remainingValueStr = remainingValue >= 0
          ? '${remainingValue.abs().toInt()}天' // Value+unit for remaining
          : '已超出: ${remainingValue.abs().toInt()}天'; // Include '超出' if negative
      remainingText = remainingValue >= 0 ? '剩余: $remainingValueStr' : remainingValueStr; // Label + value string for remaining part
      cycleAndRemainingText = '保养周期: $cycleValueStr, ${remainingValue >= 0 ? "剩余" : ""}: $remainingValueStr'; // Combine cycle and remaining
    }

    // Label Positioning
    final double labelWidth = size.width / 2 - 10; // Allow slightly more width per combined label
    // final double progressLabelX = labelWidth / 2; // OLD: Center in the left half
    // final double remainingLabelX = size.width - labelWidth / 2; // OLD: Center in the right half
    // final double targetLabelX = labelWidth / 2; // OLD: Center in the left half
    // final double cycleLabelX = size.width - labelWidth / 2; // OLD: Center in the right half

    // NEW Horizontal Positioning:
    final double progressArcTopX = splitX / 2; // Approx. horizontal center of progress arc
    final double remainingArcTopX = splitX + (size.width - splitX) / 2; // Approx. horizontal center of remaining arc
    final double targetArcBottomX = size.width * 0.5; // 修改为底部弧线的中心位置
    final double cycleArcBottomX = size.width * 0.75; // Keep near bottom-right

    // Define vertical gaps for the combined text lines
    final double topTextGap = 15.0; // Gap above top curve
    final double bottomTextGap = 15.0; // Gap below bottom curve

    // --- DRAW COMBINED TEXT --- START
    // Top Left Value (Driven)
    drawText(
        drivenText,
        Offset(progressArcTopX, size.height / 2 - topCurveHeight - topTextGap), // Position above progress arc top
        labelWidth,
        color: Colors.black, fontWeight: FontWeight.normal, fontSize: 12); // Normal font weight for combined

    // --- NEW Top Right Combined Text (Cycle + Remaining) ---
    drawText(
        cycleAndRemainingText,
        Offset(remainingArcTopX, size.height / 2 - topCurveHeight - topTextGap), // Position above remaining arc top
        labelWidth, // Use same width for now
        color: Colors.grey[700]!, // Use a neutral color
        fontWeight: FontWeight.normal, fontSize: 12);

    // 修改：目标里程放在底部弧线的弧底中央
    drawText(
        targetText,
        Offset(targetArcBottomX, size.height / 2 + bottomCurveHeight + bottomTextGap), // 定位在底部弧线的最低点下方
        labelWidth * 1.2, // 略微增加宽度以适应更长的文本
        color: Colors.black87, fontWeight: FontWeight.normal, fontSize: 12);
    // --- DRAW COMBINED TEXT --- END


    // Optional: Draw a small circle marker at the split point on the top curve
    // Paint markerPaint = Paint()..color = Colors.blue..style = PaintingStyle.fill;
    // canvas.drawCircle(splitPoint, 3.0, markerPaint);
  }

  @override
  bool shouldRepaint(covariant MaintenanceProgressPainter oldDelegate) {
    // Repaint if any relevant property changes
    return oldDelegate.component != component ||
           oldDelegate.isMileageType != isMileageType ||
           oldDelegate.currentValue != currentValue || // Keep checking currentValue? Might be redundant now
           oldDelegate.vehicleCurrentMileage != vehicleCurrentMileage ||
           oldDelegate.targetValue != targetValue ||
           oldDelegate.cycleValue != cycleValue ||
           oldDelegate.unit != unit ||
           oldDelegate.statusColor != statusColor ||
           oldDelegate.targetDate != targetDate ||
           oldDelegate.lastMaintenanceDate != lastMaintenanceDate;
  }
} 