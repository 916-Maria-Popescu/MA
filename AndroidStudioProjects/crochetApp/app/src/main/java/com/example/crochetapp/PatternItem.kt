package com.example.crochetapp

import java.util.*

data class PatternItem(
    var name: String?,
    var description: String?,
    var category: String?,
    var level: String?,
    var type: String?,
    var id: UUID = UUID.randomUUID()
)