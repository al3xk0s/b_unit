function bUnit._showCollection() {
    local collect="$1" && declare -n collect
    local result=()
    local key
    for key in ${!collect[@]}; do
        result[${#result[@]}]="[$key]: ${collect[$key]}"
    done
    
    local i
    local resultLength="${#result[@]}"
    local resultStr="${result[0]}"
    for ((i = 1 ; i < $resultLength ; i++)); do
        resultStr="$resultStr, ${result[$i]}"
    done
    echo "$resultStr"
}

function bUnit.showFailed() {
    local name="$1"
    echo "β $name"
}

function bUnit.showSuccess() {
    local name="$1"
    echo "β $name"
}

function bUnit.showDecriprion() {
    echo -e "\n        π€ $1\n "
}

function bUnit.showGroupName() {
    echo -e " π ΠΡΡΠΏΠΏΠ° $1\n"
}

function bUnit.showTestResult() {
    echo "     $1"
}

function bUnit.showModuleName() {
    echo -e "πππ Π€Π°ΠΉΠ» $1\n"
}