package com.example.crochetapp

import android.content.Context
import androidx.recyclerview.widget.RecyclerView

class PatternItemViewHolder(
    private val context: Context,
    private val binding: PatternItemCellBinding,
    private val clickListener: PatternItemClickListener
): RecyclerView.ViewHolder(binding.root) {
    fun bindPatternItem(patternItem: PatternItem) {
        binding.name.text = patternItem.name

        binding.patternCellContainer.setOnClickListener {
            clickListener.editPatternItem(patternItem)
        }
    }
}