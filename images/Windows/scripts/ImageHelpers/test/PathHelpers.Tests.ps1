. $PSScriptRoot\..\PathHelpers.ps1

Describe 'Test-MachinePath Tests' {
    Mock Get-MachinePath {return "C:\foo;C:\bar"}
    It 'Path contains item' {
        Test-MachinePath -PathItem "C:\foo" | Should Be $true
    }
    It 'Path does not containe item' {
        Test-MachinePath -PathItem "C:\baz" | Should Be $false
    }
}

Describe 'Update-MachinePath Tests' {
    Mock Get-MachinePath {return "C:\foo;C:\bar"}
    Mock Set-ItemProperty {return}
    It 'Add item to path should be at beginning' {
        Update-MachinePath -PathItem "C:\baz" | Should Be "C:\baz;C:\foo;C:\bar"
    }
}
