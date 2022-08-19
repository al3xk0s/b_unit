export B_UNIT_GROUP_PATTERN="[a-zA-Z0-9_]*"

function bUnit._getTestPrefixPattern() {
    local groupPattern="$1"
    echo "test\\.${groupPattern}\\."
}

export B_UNIT_TEST_PREFIX_PATTERN="$(bUnit._getTestPrefixPattern "${B_UNIT_GROUP_PATTERN}")"

function bUnit.assertCode() {
    local target="$1"
    local code="$2"

    if [[ "$code" != "$target" ]]; then
        bUnit.showDecriprion "Функция завершилась с кодом ошибки "$code"."
        return 1
    fi
}

function bUnit.assertEquals() {
    local expected="$1"
    local actual="$2"

    if [[ "$actual" != "$expected" ]]; then
        bUnit.showDecriprion "Ожидалось: '$expected', однако было '$actual'."
        return 1     
    fi
}

function bUnit.collectionEquals() {
    local exp="$1" && declare -n exp
    local act="$2" && declare -n act

    local success=true

    if [[ "${#exp[@]}" != "${#act[@]}" ]]; then
        bUnit.showDecriprion "Ожидалась длина: '${#exp[@]}', однако актуальная была '${#act[@]}'."
        success=false
    fi

    local key
    local expectedValue
    local actualValue

    for key in ${!exp[@]}; do
        expectedValue="${exp[$key]}"
        actualValue="${act[$key]}"

        if [[ "$expectedValue" != "$actualValue" ]]; then         
            # bUnit.showDecriprion "По ключу '$key' ожидалось значение '$expectedValue', однако было '$actualValue'"   
            success=false
        fi
    done

    [[ $success == true ]] && return 0
    bUnit.showDecriprion "Expected: { $(bUnit._showCollection exp) }"
    bUnit.showDecriprion "Actual: { $(bUnit._showCollection act) }"
    return 1
}

