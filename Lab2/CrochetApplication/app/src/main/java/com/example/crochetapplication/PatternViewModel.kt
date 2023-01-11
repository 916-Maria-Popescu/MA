package com.example.crochetapplication

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import java.util.UUID

class PatternViewModel: ViewModel() {
    var patternItems = MutableLiveData<MutableList<PatternItem>?>()

    init {
        patternItems.value = mutableListOf()
    }

    fun addPatternItem(newPattern: PatternItem) {
        val list = arrayListOf<PatternItem>()
        list.add(newPattern)
        patternItems.postValue(list)
    }

    fun updatePatternItem(
        id: UUID,
        name: String?,
        description: String?,
        category: String?,
        level: String?,
        type: String?
    ) {
        val list = patternItems.value
        val pattern = list!!.find { it.id == id }!!
        pattern.name = name
        pattern.description = description
        pattern.category = category
        pattern.level = level
        pattern.type = type
        patternItems.postValue(list)
    }

    fun deleteItem(id: UUID) {
        val list = patternItems.value
        val pattern = list!!.find { it.id == id }
        list.remove(pattern)

        patternItems.postValue(list)
    }
}