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
    echo "❌ $name"
}

function bUnit.showSuccess() {
    local name="$1"
    echo "✅ $name"
}

function bUnit.showDecriprion() {
    echo -e "\n        🤔 $1\n "
}

function bUnit.showGroupName() {
    echo -e " 🎁 Группа $1\n"
}

function bUnit.showTestResult() {
    echo "     $1"
}

function bUnit.showModuleName() {
    echo -e "🎁🎁🎁 Файл $1\n"
}