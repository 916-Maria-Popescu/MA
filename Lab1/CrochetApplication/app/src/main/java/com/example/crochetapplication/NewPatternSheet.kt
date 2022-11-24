package com.example.crochetapplication

import android.annotation.SuppressLint
import android.app.AlertDialog
import android.os.Bundle
import android.text.Editable
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.lifecycle.ViewModelProvider
import com.example.crochetapplication.databinding.FragmentNewPatternSheetBinding
import com.google.android.material.bottomsheet.BottomSheetDialogFragment

class NewPatternSheet(var patternItem: PatternItem?): BottomSheetDialogFragment() {
    private lateinit var binding: FragmentNewPatternSheetBinding
    private lateinit var patternViewModel: PatternViewModel

    @SuppressLint("SetTextI18n")
    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        val activity = requireActivity()

        if (patternItem != null) {
            binding.patternTitle.text = "Edit Pattern"
            val editable = Editable.Factory.getInstance()
            binding.name.text = editable.newEditable(patternItem!!.name)
            binding.description.text = editable.newEditable(patternItem!!.description)
            binding.category.text = editable.newEditable(patternItem!!.category)
            binding.level.text = editable.newEditable(patternItem!!.level)
            binding.type.text = editable.newEditable(patternItem!!.type)
        } else {
            binding.deleteButton.visibility = View.INVISIBLE
            binding.deleteButton.isClickable = false
            binding.deleteButton.isEnabled = false
            binding.patternTitle.text = "New Pattern"
        }

        patternViewModel = ViewModelProvider(activity).get(PatternViewModel::class.java)
        binding.saveButton.setOnClickListener {
            saveAction()
        }
        binding.deleteButton.setOnClickListener {
            val builder = AlertDialog.Builder(this.context)
            builder.setMessage("Are you sure you want to Delete?")
                .setCancelable(false)
                .setPositiveButton("Yes") { dialog, id ->
                    deleteAction()
                }
                .setNegativeButton("No") { dialog, id ->
                    // Dismiss the dialog
                    dialog.dismiss()
                }
            val alert = builder.create()
            alert.show()
//            deleteAction()
        }
    }

    private fun deleteAction() {
        binding.name.setText("")
        binding.description.setText("")
        binding.category.setText("")
        binding.level.setText("")
        binding.type.setText("")
        dismiss()
        patternViewModel.deleteItem(patternItem!!.id)
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentNewPatternSheetBinding.inflate(inflater, container, false)
        return binding.root
    }


    private fun saveAction() {
        val name = binding.name.text.toString()
        val description = binding.description.text.toString()
        val category = binding.category.text.toString()
        val level = binding.type.text.toString()
        val type = binding.level.text.toString()

        if (patternItem == null) {
            val newPattern = PatternItem(name, description, category, level, type)
            patternViewModel.addPatternItem(newPattern)
        } else {
            patternViewModel.updatePatternItem(patternItem!!.id, name, description, category, level, type)
        }
        binding.name.setText("")
        binding.description.setText("")
        binding.category.setText("")
        binding.level.setText("")
        binding.type.setText("")
        dismiss()
    }
}