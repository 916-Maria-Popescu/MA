package com.example.crochetapplication

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.example.crochetapplication.databinding.PatternItemCellBinding

class
PatternItemAdapter(
  private val patternItems: List<PatternItem>,
  private val clickListener: PatternItemClickListener
) : RecyclerView.Adapter<PatternItemViewHolder>(){
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): PatternItemViewHolder {
        val from = LayoutInflater.from(parent.context)
        val binding = PatternItemCellBinding.inflate(from, parent, false)
        return PatternItemViewHolder(parent.context, binding, clickListener)
    }

    override fun onBindViewHolder(holder: PatternItemViewHolder, position: Int) {
        holder.bindPatternItem(patternItems[position])
    }

    override fun getItemCount(): Int = patternItems.size

}