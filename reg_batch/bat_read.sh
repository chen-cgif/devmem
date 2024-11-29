#!/bin/bash

# 检查是否提供基地址
if [ "$#" -ne 1 ]; then
    echo "用法: $0 <基地址>"
    exit 1
fi

# 获取基地址
BASE_ADDRESS="$1"

# 假设寄存器地址的文件为 registers.txt
REG_FILE="registers.txt"

# 检查文件是否存在
if [ ! -f "$REG_FILE" ]; then
    echo "寄存器文件不存在: $REG_FILE"
    exit 1
fi

# 将基地址转换为十进制
BASE_DEC=$(printf "%d" "$BASE_ADDRESS")

# 遍历寄存器地址并使用 devmem 读取值
while IFS= read -r line; do
    # 跳过空行和注释行
    if [[ -z "$line" || "$line" =~ ^# ]]; then
        continue
    fi

    # 读取偏移地址和寄存器名称
    offset=$(echo "$line" | awk '{print $1}')
    register_name=$(echo "$line" | awk '{print $2}')

    if [[ $offset =~ ^0x[0-9A-Fa-f]+$ || $offset =~ ^[0-9]+$ ]]; then
        # 计算实际寄存器地址
        OFFSET_DEC=$(printf "%d" "$offset")
        REGISTER_DEC=$((BASE_DEC + OFFSET_DEC))
        REGISTER_HEX=$(printf "0x%08X" "$REGISTER_DEC")

        # 使用 devmem 读取寄存器值
        value=$(xxx_devmem "$REGISTER_HEX" d 2>&1 | grep -o '0x[0-9A-Fa-f]*$')
        
        # 输出结果
        if [ -n "$value" ]; then
            printf "%-32s | Address: %s, value: %s\n" \
                "$register_name" "$REGISTER_HEX" "$value"
        else
            echo "无法获取寄存器 $REGISTER_HEX 的值"
        fi
    else
        echo "无效的偏移地址: $offset"
    fi
done < "$REG_FILE"
