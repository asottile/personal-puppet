class desktop::test(String $pass) {
    file { '/tmp/test.txt':
        ensure  => 'file',
        content => "hello ${pass} world",
    }
}
