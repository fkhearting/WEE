#!/bin/bash
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cat > "$DIR/index.html" <<EOF
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>我的微博归档</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: -apple-system, BlinkMacSystemFont, sans-serif;
        }
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            padding: 40px 20px;
        }
        .container {
            max-width: 900px;
            margin: 0 auto;
            background: rgba(255,255,255,0.95);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 8px 32px rgba(0,0,0,0.1);
        }
        h1 {
            color: #2c3e50;
            text-align: center;
            margin-bottom: 30px;
            font-size: 28px;
            font-weight: 600;
        }
        .file-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 16px;
        }
        .file-card {
            background: #fff;
            border-radius: 12px;
            padding: 16px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
            border: 1px solid #eee;
        }
        .file-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 16px rgba(0,0,0,0.12);
            border-color: #409eff;
        }
        .file-card a {
            color: #333;
            text-decoration: none;
            font-size: 14px;
            display: block;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .file-card a:hover {
            color: #409eff;
        }
        .footer {
            text-align: center;
            margin-top: 30px;
            color: #666;
            font-size: 12px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>📚 我的微博归档</h1>
        <div class="file-grid">
EOF

count=0
# 递归遍历所有子文件夹里的 .html/.htm 文件
while IFS= read -r -d '' file; do
    name="${file#$DIR/}"
    if [[ "$name" != "index.html" ]]; then
        echo "            <div class=\"file-card\"><a href=\"$name\">📄 $name</a></div>" >> "$DIR/index.html"
        count=$((count+1))
    fi
done < <(find "$DIR" -type f \( -name "*.html" -o -name "*.htm" \) -print0)

cat >> "$DIR/index.html" <<EOF
        </div>
        <div class="footer">
            共 ${count} 条归档记录
        </div>
    </div>
</body>
</html>
EOF

echo "✅ 已递归扫描所有子文件夹，生成 ${count} 条链接！"