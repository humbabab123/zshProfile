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
SOURCES	:= $(wildcard *.zsh)
OBJECTS	:= $(patsubst %.zsh,%,$(SOURCES))

BUILD_LOCATION		:= build
DIST_LOCATION 		:= $(HOME)
RELEASE_LOCATION	:= $(HOME)

VPATH				:= $(BUILD_LOCATION)


###############################################################################
#
#   Pattern Rules
#
###############################################################################
% : %.zsh
	@mkdir -p $(BUILD_LOCATION)
	@echo "    \033[37;1mBuilding:\033[0m $@"
	@cp $< $(BUILD_LOCATION)/$@



###############################################################################
#
#   Target  Definitions
#
###############################################################################
default: $(OBJECTS)
	@echo "\033[1mBuild Finished...\033[0m"


clean:
	@$(foreach OBJECT, $(shell ls -A $(BUILD_LOCATION)), 						\
		echo "    \033[37;1mCleaning: \033[0m$(OBJECT)";						\
		rm -rf $(BUILD_LOCATION)/$(OBJECT);										)
	@echo "\033[1mClean Finished...\033[0m"


info:
	@echo "         PROJECT : $(PROJECT)"
	@echo "         SOURCES : \c"
	@$(foreach SOURCE, $(SOURCES), echo "$(SOURCE)\n                   \c";)
	@echo ""
	@echo "         OBJECTS : \c"
	@$(foreach OBJECT, $(OBJECTS), echo "$(OBJECT)\n                   \c";)
	@echo ""
	@echo "INSTALL_LOCATION : $(INSTALL_LOCATION)"
	@echo "           VPATH : $(VPATH)"


inst: default
	@$(foreach OBJECT, $(shell ls -A $(BUILD_LOCATION)),						\
		echo "    \033[37;1mInstalling: \033[0m$(OBJECT)";	   				 	\
		cp $(BUILD_LOCATION)/$(OBJECT) $(RELEASE_LOCATION)/.$(OBJECT);			)
	@echo "\033[1mInstall Finished....\033[0m"


uninst:		
	@$(foreach OBJECT, $(OBJECTS), 												\
		echo "    \033[37;1mUninstalling: \033[0m$(OBJECT)\033[0m";				\
		rm -f $(RELEASE_LOCATION)/.$(OBJECT);									)
	@echo "\033[1mUninstall Finished...\033[0m"
		
