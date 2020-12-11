################################################################################
#
#   Makefile
#
################################################################################
#
#   DESCRIPTION
#		This Makefile is used to install and un-install Script files that are
#		useful tools for production. The scripts are divided into folders that
#		indicate the type of script it is. For example, the python folder
#		contains python scripts.
#
#   AUTHOR
#		Jayme Wilkinson
#
#   HISTORY
#		Feb 28, 2018 - Initial version
#
################################################################################
PROJECT := $(notdir $(shell pwd))

DATE := `date +"%m%d%Y_%H%M%S"`

SOURCES				:= $(wildcard *.sh)
OBJECTS				:= $(patsubst %.sh,%,$(SOURCES))
BUILD_LOCATION		:= build
DIST_LOCATION 		:= dist
RELEASE_LOCATION	:= $(HOME)

VPATH				:= $(BUILD_LOCATION) \
					   $(DIST_LOCATION)

HOSTS				:= mac-mini MBPJBHD1 MBPJBHD2		

###############################################################################
#
#   Pattern Rules
#
###############################################################################
% : %.sh
	@mkdir -p $(BUILD_LOCATION)
	@echo "    \033[37;1mBuilding:\033[0m $@"
	@cp $< $(BUILD_LOCATION)/.$@

###############################################################################
#
#   Target  Definitions
#
###############################################################################
default: $(OBJECTS)
	@echo "\033[1mBuild Finished...\033[0m"

clean: 
	@$(MAKE) -s clean-build
	@$(MAKE) -s clean-dist

clean-build:
	@$(foreach OBJECT, $(shell ls -A $(BUILD_LOCATION)), 						\
		echo "    \033[37;1mCleaning: \033[0m$(OBJECT)";						\
		rm -rf $(BUILD_LOCATION)/$(OBJECT);										)
	@echo "\033[1mClean-build Finished...\033[0m"

clean-dist:
	@rm -rf $(DIST_LOCATION)/*
	@echo "\033[1mClean-dist Finished...\033[0m"

deploy: 
	@$(if $(findstring $(PROJECT),$(shell ls $(DIST_LOCATION))),					\
		$(eval PACKAGE = $(lastword $(shell ls $(DIST_LOCATION)/$(PACKAGE)*.tar)))	\
		$(foreach HOST, $(HOSTS),													\
			echo "\033[33;1m     Package:\033[0m $(PACKAGE)";						\
			echo "\033[33;1m        Host:\033[0m $(HOST)";							\
			scp $(PACKAGE) $(HOST):$(RELEASE_LOCATION);								\
		),																			\
		echo "\033[31;1mError:\033[0m Package for $(PROJECT) doesn't exist";		\
	)

package: 
	@mkdir -p $(DIST_LOCATION)
	@$(eval FILELIST = $(shell ls -A $(BUILD_LOCATION)))
	@tar -C $(BUILD_LOCATION) -cvf $(DIST_LOCATION)/$(PROJECT)-$(DATE).tar $(FILELIST)

inst:
	@$(foreach OBJECT, $(shell ls -A $(BUILD_LOCATION)),						\
		echo "    \033[37;1mInstalling: \033[0m$(OBJECT)";	   				 	\
		cp $(BUILD_LOCATION)/$(OBJECT) $(RELEASE_LOCATION)/$(OBJECT);			)
	@echo "\033[1mInstall Finished....\033[0m"

