grammar qdbus {
    regex TOP {
        <argument>
    }
    regex argument {
        '[' <.ws> 'Argument:' <.ws> 'a{sv}' <.ws> '{'
        [
            <.ws> [<varry>]+ % [ <.ws> ',' <.ws> ]
        ]?
        '}]'
        <.ws>?
    }
    rule varry { <key-str> '=' <variant> }
    token key-str { ‘"’ <[\S\s]-["]>* ‘"’ }
    proto regex variant { * }
    rule variant:sym<Argument> {
        '['
        'Variant:' <argument>
        ']'
    }
    rule variant:sym<QString> {
        '['
            <.ws> 'Variant(QString):' <.ws>
            ‘"’
                $<QString>=(<[\S\s]-["]>*)
            ‘"’
            <.ws>
        ']'
    }
    rule variant:sym<bool> {
        '['
            <.ws> 'Variant(bool):' <.ws>
            #‘"’
                $<bool>=([true|false])
            #‘"’
            <.ws>
        ']'
    }
    rule variant:sym<QStringList> {
        '['
            <.ws> 'Variant(QStringList):' <.ws>
            '{'
            [
                ‘"’
                    $<list>=(<[\S\s]-["]>*)
                ‘"’
            ]+ % [<.ws> ',' <.ws>]
            '}'
            <.ws>
        ']'
    }
}
