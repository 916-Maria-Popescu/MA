package com.example.crochetapp

import android.annotation.SuppressLint
import android.os.Bundle
import android.text.Editable
import android.view.View
import com.google.android.material.bottomsheet.BottomSheetDialogFragment

class NewPatternSheet(var patternItem: PatternItem?): BottomSheetDialogFragment() {
    private lateinit var binding: FragmentNewPatternBinding
    private lateinit var gemViewModel: PatternViewModel

    @SuppressLint("SetTextI18n")
    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        val activity = requireActivity()

        if (patternItem != null) {
            binding.pattern.text = "Edit Gem"
            val editable = Editable.Factory.getInstance()
            binding.name.text = editable.newEditable(gemItem!!.name)
            binding.desc.text = editable.newEditable(gemItem!!.desc)
            binding.colour.text = editable.newEditable(gemItem!!.colour)
            binding.hardness.text = editable.newEditable(gemItem!!.hardness)
            binding.birthstone.text = editable.newEditable(gemItem!!.birthstone)
        } else {
            binding.deleteButton.visibility = View.INVISIBLE
            binding.deleteButton.isClickable = false
            binding.deleteButton.isEnabled = false
            binding.gemTitle.text = "New Gem"
        }

        gemViewModel = ViewModelProvider(activity).get(GemViewModel::class.java)
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
        binding.desc.setText("")
        binding.colour.setText("")
        binding.hardness.setText("")
        binding.birthstone.setText("")
        dismiss()
        gemViewModel.deleteItem(gemItem!!.id)
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentNewGemSheetBinding.inflate(inflater, container, false)
        return binding.root
    }


    private fun saveAction() {
        val name = binding.name.text.toString()
        val desc = binding.desc.text.toString()
        val colour = binding.colour.text.toString()
        val hardness = binding.hardness.text.toString()
        val birthstone = binding.birthstone.text.toString()

        if (gemItem == null) {
            val newGem = GemItem(name, desc, colour, hardness, birthstone)
            gemViewModel.addGemItem(newGem)
        } else {
            gemViewModel.updateGemItem(gemItem!!.id, name, desc, colour, hardness, birthstone)
        }
        binding.name.setText("")
        binding.desc.setText("")
        binding.colour.setText("")
        binding.hardness.setText("")
        binding.birthstone.setText("")
        dismiss()
    }
}