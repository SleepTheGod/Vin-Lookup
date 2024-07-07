#!/bin/bash
echo -e "\e[31m ███████████                      ████     ███████████  ███                                      \e[0m"
echo -e "\e[31m░░███░░░░░███                    ░░███    ░█░░░███░░░█ ░░░                                       \e[0m"
echo -e "\e[31m ░███    ░███   ██████   ██████   ░███    ░   ░███  ░  ████  █████████████    ██████            \e[0m"
echo -e "\e[31m ░██████████   ███░░███ ░░░░░███  ░███        ░███    ░░███ ░░███░░███░░███  ███░░███           \e[0m"
echo -e "\e[31m ░███░░░░░███ ░███████   ███████  ░███        ░███     ░███  ░███ ░███ ░███ ░███████            \e[0m"
echo -e "\e[31m ░███    ░███ ░███░░░   ███░░███  ░███        ░███     ░███  ░███ ░███ ░███ ░███░░░             \e[0m"
echo -e "\e[31m █████   █████░░██████ ░░████████ █████       █████    █████ █████░███ █████░░██████            \e[0m"
echo -e "\e[31m░░░░░   ░░░░░  ░░░░░░   ░░░░░░░░ ░░░░░       ░░░░░    ░░░░░ ░░░░░ ░░░ ░░░░░  ░░░░░░             \e[0m"
echo -e "\e[31m                                                                                                 \e[0m"
echo -e "\e[31m                                                                                                 \e[0m"
echo -e "\e[31m █████   █████  ███                █████                         █████                           \e[0m"
echo -e "\e[31m░░███   ░░███  ░░░                ░░███                         ░░███                            \e[0m"
echo -e "\e[31m ░███    ░███  ████  ████████      ░███         ██████   ██████  ░███ █████ █████ ████ ████████ \e[0m"
echo -e "\e[31m ░███    ░███ ░░███ ░░███░░███     ░███        ███░░███ ███░░███ ░███░░███ ░░███ ░███ ░░███░░███\e[0m"
echo -e "\e[31m ░░███   ███   ░███  ░███ ░███     ░███       ░███ ░███░███ ░███ ░██████░   ░███ ░███  ░███ ░███\e[0m"
echo -e "\e[31m  ░░░█████░    ░███  ░███ ░███     ░███      █░███ ░███░███ ░███ ░███░░███  ░███ ░███  ░███ ░███\e[0m"
echo -e "\e[31m    ░░███      █████ ████ █████    ███████████░░██████ ░░██████  ████ █████ ░░████████ ░███████ \e[0m"
echo -e "\e[31m     ░░░      ░░░░░ ░░░░ ░░░░░    ░░░░░░░░░░░
vin_lookup() {
    local vin="$1"
    local url="https://vpic.nhtsa.dot.gov/api/vehicles/DecodeVinValuesBatch/"
    local params="format=json&data=${vin}"
    local response=$(curl -s -X POST -d "${params}" -H "Content-Type: application/x-www-form-urlencoded" "${url}")
    if [[ -z "${response}" ]]; then
        echo "Failed to retrieve VIN information."
        return 1
    fi
    local vin=$(echo "${response}" | jq -r '.Results[0].VIN')
    local make=$(echo "${response}" | jq -r '.Results[0].Make')
    local model=$(echo "${response}" | jq -r '.Results[0].Model')
    local model_year=$(echo "${response}" | jq -r '.Results[0].ModelYear')
    local body_class=$(echo "${response}" | jq -r '.Results[0].BodyClass')
    local drive_type=$(echo "${response}" | jq -r '.Results[0].DriveType')
    local engine_config=$(echo "${response}" | jq -r '.Results[0].EngineConfiguration')
    local engine_cylinders=$(echo "${response}" | jq -r '.Results[0].EngineCylinders')
    local fuel_type=$(echo "${response}" | jq -r '.Results[0].FuelTypePrimary')
    echo "VIN: ${vin}"
    echo "Make: ${make}"
    echo "Model: ${model}"
    echo "Model Year: ${model_year}"
    echo "Body Class: ${body_class}"
    echo "Drive Type: ${drive_type}"
    echo "Engine Configuration: ${engine_config}"
    echo "Engine Cylinders: ${engine_cylinders}"
    echo "Fuel Type: ${fuel_type}"
}
clear
read -p "Enter VIN #: " vin
vin_lookup "${vin}"
