#!/bin/bash

path="./github/"

d_url=`curl -s "https://api.github.com/repos/Loyalsoldier/v2ray-rules-dat/releases/latest" | grep "browser_download_url" | grep "gfw.txt" | cut -d'"' -f4`

gfw_txt=`curl -s -L "${d_url}"`

# 获取文件总行数
total_lines=`echo "${gfw_txt}" | wc -l`

gfw_json=""

# 逐行处理文件内容
for((line_num=1;line_num<=${total_lines};line_num++))
do
  line=`echo "${gfw_txt}" | sed -n "${line_num}p"`
  line="      \"${line}\","
  gfw_json="${gfw_json}
${line}"
done

gfw_json="${gfw_json}
      \"fezq2g90kz.com\""
txt1="{
  "version": 1,
  "rules": [
    {
      "domain_suffix": ["
txt2="
      ]
    }
  ]
}"

echo "${txt1}${gfw_json}${txt2}" > "${path}gfw.json"

########################################

now_time=`date`

txt="# gfwlist
## raw -> json, based on [v2ray-rules-dat](https://github.com/Loyalsoldier/v2ray-rules-dat)
${now_time}
"
echo "${txt}" > "${path}README.md"

########################################

cd ${path}
git add .
git commit -m "${now_time}"
git push -u origin main
