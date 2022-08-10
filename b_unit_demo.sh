#!/usr/bin/bash

root="$BASH_OPT/b_unit"

source $root/b_unit.sh


function @test.testOne.example() {
    bUnit.assertEquals one one
}

function @test.testOne.exampleCollectEquals() {
    local expected=(1 2 3 4 'some')
    local actual=(1 2 3 4 'some')
    bUnit.collectionEquals expected actual
}

function @test.testTho.exampleFailed() {
    bUnit.assertEquals one tho
}

function @test.testTho.exampleFailedCode() {
    bUnit.assertCode 0 12
}

function @test.testTho.exampleCollectEqualsFailed() {
    local expected=(1 3 3 4 'someone')
    local actual=(1 1 3 4 'some')
    bUnit.collectionEquals expected actual
}

function @test.testTho.exampleCollectEqualsFailedLength() {
    local expected=(1 2 3 4 'someone')
    local actual=(1 3 4 'someone')
    bUnit.collectionEquals expected actual
}

function @test.testTho.exampleCollectEqualsMapFailed() {
    declare -A _testThoExpectedMap
    declare -A _testThoActualMap

    _testThoExpectedMap[key]=val
    _testThoExpectedMap[key2]=val2
    _testThoExpectedMap[key3]=val3

    _testThoActualMap[key1]=val
    _testThoActualMap[key2]=val2
    _testThoActualMap[key3]=val3

    bUnit.collectionEquals _testThoExpectedMap _testThoActualMap
}

function @test.testOfTest.getAllGroupsPattern() {
    local actual="$(bUnit._getGroupPattern)"
    local expected="${B_UNIT_TEST_PREFIX_PATTERN}"
    bUnit.assertEquals "$expected" "$actual"
}

function @test.testOfTest.getConcreteGroupsPattern() {
    local actual="$(bUnit._getGroupPattern _testOne _testTho _testOfTest)"
    local expected="$(bUnit._getTestPrefixPattern "_testOne|_testTho|_testOfTest")"

    bUnit.assertEquals "$expected" "$actual"
}

    
bUnit.runTestGroups