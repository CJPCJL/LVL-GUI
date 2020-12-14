#!/usr/bin/perl -w

#-----------------------------------
#		lvl GUI
# owner: ChenJP
# Date : 2020-01-21
# No.emplyee : 800020
# Locate : XM-FJ-CHINA
# Version: v003
# history: v003 add error file type warning and log file
#
# ----------------------------------

	use Tk;
	use strict;
	use File::Basename;
	
	my $mw = MainWindow -> new;
	$mw->geometry("615x415");
	$mw->title(" layout vs layout ");
	my $Frame1 = $mw->Frame(); #for input information
	my $Frame2 = $mw->Frame(); #for area
	my $Frame3 = $mw->Frame(); #for copyright information

#------------buttons-----------------

	my $button_exit = $Frame2->Button(-text => "exit",-width => 5,-command => sub{exit})->pack();
	my $button_LVL = $Frame2->Button(-text => "LVL",-width => 5,-command => \&button_vs_sub)->pack();
	my $button_view_result = $Frame2->Button(-text => "view\nresult",-width => 5,-command => \&button_view_result_sub)->pack();

	my $button_select_gds1 = $Frame1->Button(-text => "...",-width => 5,-command => \&button_openfile1)->pack();
	my $button_select_gds2 = $Frame1->Button(-text => "...",-width => 5,-command => \&button_openfile2)->pack();
	my $button_select_layer_list = $Frame1->Button(-text => "...",-width => 5,-command => \&button_openfile3)->pack();
	my $button_select_layer_map = $Frame1->Button(-text => "...",-width => 5,-command => \&button_openfile5)->pack();

#------------entrys-------------------

	my $GDS_1 = ""; #layout1 (1.gds)
	my $GDS_2 = ""; #layout2 (2.gds)
	my $layer_list = ""; #layer's list ("AA" "M1" ...)
	my $one_layer = ""; #get one layer to make lvl ("AA")
	my $layer_map = ""; #layer_map (*.map or *.layermap)
	
	my $entry1_GDS_1 = $Frame1->Entry(-textvariable => \$GDS_1,-background=>"white",-width=>60)->pack();
	my $entry2_GDS_2 = $Frame1->Entry(-textvariable => \$GDS_2,-background=>"white",-width=>60)->pack();
	my $entry3_layer_list = $Frame1->Entry(-textvariable => \$layer_list,-background=>"white",-width=>60)->pack();
	my $entry4_one_layer = $Frame1->Entry(-textvariable => \$one_layer,-background=>"white",-width=>60)->pack();
	my $entry5_layer_map = $Frame1->Entry(-textvariable => \$layer_map,-background=>"white",-width=>60)->pack();

#------------label---------------------

	my $label_gds_1 = $Frame1->Label(-text => "GDS_1\:");
	my $label_gds_2 = $Frame1->Label(-text => "GDS_2\:");
	my $label_layer_list = $Frame1->Label(-text => "Layer_List\:");
	my $label_one_layer = $Frame1->Label(-text => "One_Layer\:");
	my $label_layer_map = $Frame1->Label(-text => "Layer_Map\:");
	my $copyright = $Frame3->Label(-text => "< Copyright\: Design by chenjp in XM-FJ-CHINA >")->pack();

#------------Text_area-----------------

	my $label_result = $Frame2->Label(-text=>"Log_Inform\:");
	my $text_area = $Frame2->Text(-background=>"white",-width=>60,-height=>10);

#------------widgets place-------------

	$Frame1 -> grid(-row=>1,-column=>1,-rowspan=>5,-columnspan=>3);
	
	$label_gds_1 -> grid(-row=>1,-column=>1,-padx=>7,-pady=>7,-sticky=>"w");
	$label_gds_2 -> grid(-row=>2,-column=>1,-padx=>7,-pady=>7,-sticky=>"w");
	$label_layer_list -> grid(-row=>3,-column=>1,-padx=>7,-pady=>7,-sticky=>"w");
	$label_one_layer -> grid(-row=>4,-column=>1,-padx=>7,-pady=>7,-sticky=>"w");
	$label_layer_map -> grid(-row=>5,-column=>1,-padx=>7,-pady=>7,-sticky=>"w");

	$entry1_GDS_1 -> grid(-ipady=>4,-row=>1,-column=>2,-padx=>5,-pady=>5);	
	$entry2_GDS_2 -> grid(-ipady=>4,-row=>2,-column=>2,-padx=>5,-pady=>5);	
	$entry3_layer_list -> grid(-ipady=>4,-row=>3,-column=>2,-padx=>5,-pady=>5);	
	$entry4_one_layer -> grid(-ipady=>4,-row=>4,-column=>2,-padx=>5,-pady=>5);
	$entry5_layer_map -> grid(-ipady=>4,-row=>5,-column=>2,-padx=>5,-pady=>5);	
	
	$button_select_gds1 -> grid(-row=>1,-column=>3,-sticky=>"w");
	$button_select_gds2 -> grid(-row=>2,-column=>3,-sticky=>"w");
	$button_select_layer_list -> grid(-row=>3,-column=>3,-sticky=>"w");
	$button_select_layer_map -> grid(-row=>5,-column=>3,-sticky=>"w");

	$Frame2 -> grid(-row=>6,-column=>1,-rowspan=>3,-columnspan=>3);
	
	$label_result -> grid(-row=>1,-column=>1,-padx=>7,-pady=>7,-sticky=>"nw");
	$text_area -> grid(-row=>1,-column=>2,-rowspan=>3,-padx=>5,-pady=>5,-ipady=>4,-sticky=>"news");
	$text_area -> insert('end',"*******************************\nPlease give the GDS_1 and GDS_2 at least!\nNotice the input files's type\n*******************************\n");

	$button_LVL -> grid(-row=>1,-column=>3,-ipady=>10,-pady=>5,-sticky=>"w");
	$button_view_result -> grid(-row=>2,-column=>3,-ipady=>10,-pady=>5,-sticky=>"w");
	$button_exit -> grid(-row=>3,-column=>3,-ipady=>10,-pady=>5,-sticky=>"w");
	
	$Frame3 -> grid(-row=>9,-column=>1,-columnspan=>3);
	
	MainLoop;

sub button_vs_sub {

	$GDS_1 = $entry1_GDS_1 -> get();
	$GDS_2 = $entry2_GDS_2 -> get();
	$layer_list= $entry3_layer_list -> ger();
	$one_layer = $entry4_one_layer -> get();
	$layer_map = $entry5_layer_map -> get();

#******************warning or error **********************

	if ( $GDS_1 eq "") {
	my $warning_box1 => $Frame1 -> messageBox(-title => '****** Warning1 ! ******', -message => "lack of GDS_1 \nPlease enter or select a < GDS > file",-type => 'OK');
	}

	if ( $GDS_2 eq "") {
	my $warning_box2 => $Frame1 -> messageBox(-title => '****** Warning2 ! ******', -message => "lack of GDS_2 \nPlease enter or select a < GDS > file",-type => 'OK');
	}

#**********************************************************

	if (($GDS_1 ne "") && ($GDS_2 ne "") && ($layer_map ne "") && ($one_layer ne "")) {
		my @suffix = qw(.map .mapping);
		my $layer_map_basename = basename($layer_map,@suffix);		
		system("perl get_partial_map.pl $layer_list $layer_map_basename.map");
		system("perl get_lvl_runset.pl partical_$layer_map_basename.map $GDS_1 $GDS_2");
		system("calibre -drc lvl.cal");
		$text_area ->insert('end',"layout Vs layout Done ^ - ^ :) !\nPlease check the result\n****************************\n");
	}elsif (($GDS_1 ne "") && ($GDS_2 ne "") && ($layer_map ne "")) {
		system("perl get_lvl_runset.pl $layer_map $GDS_1 $GDS_2");
		system("calibre -drc lvl.cal");
		$text_area ->insert('end',"layout Vs layout Done ^ - ^ :) !\nPlease check the result\n****************************\n");
	}elsif (($GDS_1 ne "") && ($GDS_2 ne "")) {
		system("dbdiff -system GDS -design $GDS_1 -refdesign $GDS_2 -write_xor_rules lvl.cal");
		system("calibre -drc lvl.cal");
		$text_area ->insert('end',"layout Vs layout Done ^ - ^ :) !\nPlease check the result\n****************************\n");
	}
} #sub

sub button_view_result_sub {
	system("vim lvl.cal.summary");
	system("calibre -rve lvl.cal.asc");
	$text_area -> insert('end',"check the lvl.cal.summary and Calibre RVE results done!\n************************\n");
}

sub button_openfile1 {
	my $types;
	my $file;
	my @types=
	  (["GDS files",".gds",".GDS"],
	   ["All files",'*']
	);
	$file=$mw->getOpenFile(-filetypes=>\@types);
	if (defined $file and $file ne '') {
		$entry1_GDS_1->delete(0,'end');
		$entry1_GDS_1->insert(0,$file);
		$entry1_GDS_1->xview('end');
	}
}

sub button_openfile2 {
	my $types;
	my $file;
	my @types=
	  (["GDS files",".gds",".GDS"],
	   ["All files",'*']
	);
	$file=$mw->getOpenFile(-filetypes=>\@types);
	if (defined $file and $file ne '') {
		$entry2_GDS_2->delete(0,'end');
		$entry2_GDS_2->insert(0,$file);
		$entry2_GDS_2->xview('end');
	}
}
	
sub button_openfile3 {
	my $types;
	my $file;
	my @types=
	  (["layer list file",'','TEXT'],
	   ["All files",'*']
	);
	$file=$mw->getOpenFile(-filetypes=>\@types);
	if (defined $file and $file ne '') {
		$entry3_layer_list->delete(0,'end');
		$entry3_layer_list->insert(0,$file);
		$entry3_layer_list->xview('end');
	}
}

sub button_openfile5 {
	my $types;
	my $file;
	my @types=
	  (["layer map file",'.map','TEXT'],
	   ["All files",'*']
	);
	$file=$mw->getOpenFile(-filetypes=>\@types);
	if (defined $file and $file ne '') {
		$entry5_layer_map->delete(0,'end');
		$entry5_layer_map->insert(0,$file);
		$entry5_layer_map->xview('end');
	}
}


