    local telesope = require 'telescope'
    telesope.setup {
        defaults = {
            file_ignore_patterns = {
                "%.tar",
                "%.pdf",
                "%.jpg",
                "%.jpeg",
                "%.png",
                "%.png",
                "%.eml"
            }
        }
    }

