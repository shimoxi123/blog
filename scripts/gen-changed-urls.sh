#!/usr/bin/env bash
set -euo pipefail

# 强制按字节序比较：脚本里用 LC_ALL=C 排序，但 comm/cmp 会跟随环境 locale，
# 在 zh_CN.UTF-8 等非字节序 locale 下 comm 会因“输入未排序”直接报错退出。
export LC_ALL=C

# 参数说明：
# 1: 上一次构建目录
# 2: 当前构建目录
# 3: 站点根地址（例如 https://www.san3.cn）
# 4: 输出文件路径（txt，一行一个 URL）
PREV_DIR="${1:?missing prev dir}"
CURR_DIR="${2:?missing curr dir}"
BASE_URL="${3:?missing base url}"
OUT_FILE="${4:?missing output file}"

# 统一去掉末尾斜杠，避免出现双斜杠 URL
BASE_URL="${BASE_URL%/}"

tmp_prev="$(mktemp)"
tmp_curr="$(mktemp)"
tmp_changed="$(mktemp)"

# 生成文件相对路径清单（仅文件，不含目录）
find "${PREV_DIR}" -type f -printf '%P\n' | LC_ALL=C sort > "${tmp_prev}"
find "${CURR_DIR}" -type f -printf '%P\n' | LC_ALL=C sort > "${tmp_curr}"

# 先收集新增/删除文件（两边不一致的路径）
comm -3 "${tmp_prev}" "${tmp_curr}" | sed 's/^[[:space:]]*//' > "${tmp_changed}"

# 再收集同名但内容变化的文件
comm -12 "${tmp_prev}" "${tmp_curr}" | while read -r rel; do
  if ! cmp -s "${PREV_DIR}/${rel}" "${CURR_DIR}/${rel}"; then
    echo "${rel}" >> "${tmp_changed}"
  fi
done

# 将相对路径转成可访问 URL：
# - 根 index.html -> /
# - 任意目录 index.html -> /dir/
# - 其他文件保持文件路径
sort -u "${tmp_changed}" | while read -r rel; do
  [ -z "${rel}" ] && continue
  if [ "${rel}" = "index.html" ]; then
    echo "${BASE_URL}/"
  elif [[ "${rel}" == */index.html ]]; then
    echo "${BASE_URL}/${rel%index.html}"
  else
    echo "${BASE_URL}/${rel}"
  fi
done > "${OUT_FILE}"

rm -f "${tmp_prev}" "${tmp_curr}" "${tmp_changed}"
