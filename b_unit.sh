root="$BASH_OPT/b_unit"

import util.sh
import b_unit_assert.sh
import b_unit_ui.sh

function bUnit.test() {
    local decription="$1"
    local callback="$2"

    if [[ ${#@} == 1 ]]; then
        callback="$1"
        decription="$(echo "$callback" | sed "s|${B_UNIT_TEST_PREFIX_PATTERN}||g")"        
    fi

    local out
    out="$($callback)"
    local success="$?"

    if [[ "$success" == "0" ]]; then 
        bUnit.showSuccess "$decription"
    else
        bUnit.showFailed "$decription"
        echo -e "$out"
    fi

    return $success
}

function bUnit._getGroupPattern() {
    local patternGroups="${B_UNIT_GROUP_PATTERN}"

    if [[ ${#@} != 0 ]]; then
        patternGroups="$(echo "${*}" | sed 's\ \|\g')"
    fi

    local pattern="$(bUnit._getTestPrefixPattern "${patternGroups}")"
    echo $pattern
}

function bUnit._getGroupsOfTest() {
    local result="$1" && declare -n result
    result=()

    local item
    local group
    local dotIndex

    for item in ${@:2}; do
        group="$(echo "$item" | sed 's|test\.||g')"
        dotIndex="$(expr index "$group" '.')"
        group="${group:0:dotIndex-1}"

        if ! array.contains "$group" ${result[@]}; then
            result["${#result[@]}"]="$group"
        fi
    done
}

function bUnit.runTestGroups() {
    local pattern="$(bUnit._getGroupPattern ${@})"
    local tests=($(compgen -ca | grep "$pattern"))
    local groups

    bUnit._getGroupsOfTest groups ${tests[@]}

    local group
    local testcase
    local testOut

    local success=0
    local failed=0

    echo -e "\n"
    for group in ${groups[@]}; do
        bUnit.showGroupName "$group"
        for testcase in ${tests[@]}; do            
            if [[ ! "$testcase" =~ (test.${group}\.) ]]; then
                continue
            fi
            testOut="$(bUnit.test "$testcase")"
            [[ "$?" == 0 ]] && success=$(( $success + 1 )) || failed=$(( $failed + 1 ))
            bUnit.showTestResult "$testOut"
        done
        echo -e "\n"
    done
    echo    
    echo "Выполнены: $success"
    echo "Провалены: $failed"
    echo "Всего: $(( $success + $failed ))"
    echo
}