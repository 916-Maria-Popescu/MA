package com.example.crochetapplication

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.ViewModelProvider
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.crochetapplication.databinding.ActivityMainBinding

class MainActivity : AppCompatActivity(), PatternItemClickListener {
    private lateinit var binding: ActivityMainBinding
    private lateinit var patternViewModel: PatternViewModel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)
        patternViewModel = ViewModelProvider(this).get(PatternViewModel::class.java)
        binding.newPatternButton.setOnClickListener {
            NewPatternSheet(null).show(supportFragmentManager, "newPatternTag")
        }
        setRecyclerView()
    }

    private fun setRecyclerView() {
        val mainActivity = this
        patternViewModel.patternItems.observe(this) { list->
            binding.patternsCollectionRecyclerView.apply {
                layoutManager = LinearLayoutManager(applicationContext)
                adapter = PatternItemAdapter(list!!, mainActivity)
            }
        }
    }

    override fun editPatternItem(patternItem: PatternItem) {
        NewPatternSheet(patternItem).show(supportFragmentManager, "newPatternTag")
    }
}