#!/bin/bash

path="./github/"

d_url="https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/gfw.txt"

gfw_txt=`curl -s -L "${d_url}"`

total_lines=`echo "${gfw_txt}" | wc -l`

gfw_json=""

for((line_num=1;line_num<=${total_lines};line_num++))
do
  line=`echo "${gfw_txt}" | sed -n "${line_num}p"`
  line="        \"${line}\","
  gfw_json="${gfw_json}
${line}"
done

gfw_json="${gfw_json}
        \"fezq2g90kz.com\""
txt1="{
  \"version\": 1,
  \"rules\": [
    {
      \"domain_suffix\": ["
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
