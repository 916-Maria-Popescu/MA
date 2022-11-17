package com.example.crochetapp

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.ViewModelProvider
import androidx.recyclerview.widget.LinearLayoutManager

class MainActivity : AppCompatActivity(), PatternItemClickListener {
    private lateinit var binding: Activity
    private lateinit var patternViewModel: PatternViewModel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)
        patternViewModel = ViewModelProvider(this).get(PatternViewModel::class.java)
        binding.newGemButton.setOnClickListener {
            NewPatternSheet(null).show(supportFragmentManager, "newGemTag")
        }
        setRecyclerView()
    }

    private fun setRecyclerView() {
        val mainActivity = this
        patternViewModel.patternItems.observe(this) {
            binding.gemsCollectionRecyclerView.apply {
                layoutManager = LinearLayoutManager(applicationContext)
                adapter = GemItemAdapter(it, mainActivity)
            }
        }
    }

    override fun editGemItem(patternItem: PatternItem) {
        NewPatternSheet(patternItem).show(supportFragmentManager, "newPatternTag")
    }
}