# carsave_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


程序员御风
yt-dlp.exe ^
    --cookies cookies.txt ^
    -f best ^
    --download-archive archive.txt ^
    --limit-rate 2M ^
    -o "D:/下载视频/%(playlist_title)s/%(playlist_index)s - %(title)s.%(ext)s" ^
    "https://www.youtube.com/watch?v=jaFkRMy76h0&list=PL8-cqi9m5f4ZPgtkUqBF9fQQYn0-fUcW2" ^
    "https://www.youtube.com/watch?v=rhPyku1avuo&list=PL8-cqi9m5f4Zrzl73p773wmDuXTAPOI7T" ^
    "https://www.youtube.com/watch?v=4INHXju0azI&list=PL8-cqi9m5f4ajvCG4lK21BfkQ3F3Hd2gB" ^
    "https://www.youtube.com/watch?v=QYO5_riePOQ&list=PL8-cqi9m5f4Y0MiXIxbfPLVB9rrwSxm49"
	
yt-dlp.exe ^
    --cookies cookies.txt ^
    -f best ^
    --download-archive archive.txt ^
    --limit-rate 2M ^
    -o "D:/下载视频/%(playlist_title)s/%(playlist_index)s - %(title)s.%(ext)s" ^
    "https://www.youtube.com/@bywind1990/videos"

ai花生进化论
yt-dlp.exe ^
    --cookies cookies.txt ^
    -f best ^
    --download-archive archive.txt ^
	--limit-rate 2M^
    -o "D:/下载视频/%(playlist_title)s/%(playlist_index)s - %(title)s.%(ext)s" ^
    "https://www.youtube.com/@Alchain/videos" 

零度解说
yt-dlp.exe ^
     --cookies cookies.txt ^
     -f best ^
     --download-archive archive.txt ^
     --limit-rate 2M^
     -o "D:/下载视频/%(playlist_title)s/%(playlist_index)s - %(title)s.%(ext)s" ^
     "https://www.youtube.com/@lingdujieshuo/videos" 



最近30天
	t-dlp.exe --dateafter today-30d https://www.youtube.com/c/<channel_name>
下载短视频
	yt-dlp.exe --max-filesize 100m https://www.youtube.com/c/<channel_name>
更新软件
	yt-dlp.exe -U
自己添加视频链接
	-a links.txt
首尾
	--playlist-start 5 
	--playlist-end 10
	
此选项会明确禁止覆盖已存在的文件。如果文件已存在，yt-dlp 会跳过下载
	--no-overwrites：
避免重复下载
	--download-archive   archive.txt
只下载音频
	-x --audio-format mp3
网速限制
	--limit-rate 1M

