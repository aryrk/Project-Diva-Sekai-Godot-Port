extends Node

func add_all_anim(AnimPlayer,AnimTree):
	var animation_player : AnimationPlayer = AnimPlayer
	var animation_tree : AnimationTree = AnimTree
	
	
	# Pastikan AnimationPlayer dan AnimationTree diisi
	if not animation_player:
		return
	if not animation_tree:
		return

	# Ambil root dari AnimationTree
	var blend_tree = AnimationNodeBlendTree.new()
	animation_tree.tree_root = blend_tree

	# Ambil semua animasi dari AnimationPlayer
	var animations = animation_player.get_animation_list()
	
	if animations.size() == 0:
		return
	
	# Buat node Animation untuk setiap animasi
	for anim_name in animations:
		var anim_node = AnimationNodeAnimation.new()
		anim_node.animation = anim_name
		blend_tree.add_node(anim_name, anim_node)
	
	var first_add_node = ""

	var second_add = false
	var previous_add = ""
	# Menambahkan node Add2 (Combine two animations using an addition operation)
	for i in range(0, animations.size()):
		var add_node = AnimationNodeAdd2.new()
		add_node.sync = true
		
		var anim1_name = animations[i]
		var anim2_name = animations[i + 1] if i + 1 < animations.size() else anim1_name
		var anim3_name = animations[i + 2] if i + 2 < animations.size() else anim1_name

		var current_add_node = anim1_name + "_add_node"
		blend_tree.add_node(current_add_node, add_node)
		animation_tree.set("parameters/"+current_add_node+"/add_amount", 1)
		
		
		if first_add_node == "":
			first_add_node = current_add_node
		
		if anim2_name != anim1_name:
			second_add = true
		else:
			second_add = false
			
		print (second_add)
			
		if i >= animations.size()-1:
			blend_tree.connect_node(previous_add,1,anim1_name)
			print("Anim [ "+anim1_name+" ("+str(i)+") (1)] connected to " + previous_add)
		else:
			blend_tree.connect_node(current_add_node,0,anim1_name)
			print("Anim [ "+anim1_name+" ("+str(i)+") (0)] connected to " + current_add_node)
			
			if !second_add:
				blend_tree.connect_node(current_add_node,1,anim2_name)
				print("Anim [ "+anim2_name+" ("+str(i)+") (1)] connected to " + current_add_node)
			else:
				if previous_add!="":
					blend_tree.connect_node(previous_add,1,current_add_node)
					print("Node [ "+current_add_node+" (1)] connected to " + previous_add)
		previous_add = current_add_node
		
	blend_tree.connect_node("output",0,first_add_node)
	print(first_add_node+" connected to output")
		
