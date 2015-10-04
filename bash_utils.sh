#!/bin/bash
#
# A collection of utility functions for Bash scripts.
# 
# Copyright (C) 2015 Kathrin Hanauer
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

######################################################################
# Debug and error functions
######################################################################

DEBUG=0

#----------------------------------------------------------------------
# Usage: debug ARGS
# Prints all function arguments if Variable DEBUG is not set to 0.
#----------------------------------------------------------------------
debug() {
  if [ "${DEBUG}" -ne 0 ]
  then
    echo -e $*
  fi
}
#----------------------------------------------------------------------

#----------------------------------------------------------------------
# Usage: enableDebugMode 
# Enables debug mode.
#----------------------------------------------------------------------
enableDebugMode() {
  DEBUG=1
	debug "Debug mode is enabled."
}
#----------------------------------------------------------------------

#----------------------------------------------------------------------
# Usage: error MSG
# Prints an error message to STDERR and exits the program with return
# code 1.
#----------------------------------------------------------------------
error() {
  echo -e $* >&2
  exit 1
}
#----------------------------------------------------------------------

######################################################################
# Directory and file operations
######################################################################

#----------------------------------------------------------------------
# Usage: extract_dir FILENAME
# Extracts a file's directory
#----------------------------------------------------------------------
extract_dir() {
  local FILE=$1
  local DIRNAME=$(dirname "${FILE}")
  echo "${DIRNAME}"
}
#----------------------------------------------------------------------

#----------------------------------------------------------------------
# Usage: extract_extension FILENAME
# Extracts a file's extension, i.e., the part after the dot.
#----------------------------------------------------------------------
extract_extension() {
  local FILE=$1
  local FILENAME=$(basename "${FILE}")
  local EXT="${FILENAME##*.}"
  echo "${EXT}"
}
#----------------------------------------------------------------------

#----------------------------------------------------------------------
# Usage: extract_basename FILENAME
# Extracts a file's basename, i.e., the file name without path.
#----------------------------------------------------------------------
extract_basename() {
  local FILE=$1
  local FILENAME=$(basename "${FILE}")
  echo "${FILENAME}"
}
#----------------------------------------------------------------------

#----------------------------------------------------------------------
# Usage: extract_base FILENAME
# Extracts the name of a file without path and extension.
#----------------------------------------------------------------------
extract_base() {
  local FILE=$1
  local FILENAME=$(basename "${FILE}")
  local BASE="${FILENAME%.*}"
  echo "${BASE}"
}
#----------------------------------------------------------------------

#----------------------------------------------------------------------
# Usage: expand_path PATH
# Expands directory paths, e.g. relative paths, using cd and pwd.
#----------------------------------------------------------------------
expand_path() {
	local RELPATH=$1
  local LONGPATH=""
	if [ -z "${RELPATH}" ]
	then
	  LONGPATH=$(pwd)
	else
	  LONGPATH=$(cd $1; pwd)
	fi
  echo ${LONGPATH}
}
#----------------------------------------------------------------------

#----------------------------------------------------------------------
# Usage: expand_filepath PATH
# Expands file paths, e.g. relative paths, using cd and pwd.
#----------------------------------------------------------------------
expand_filepath() {
	local FILE=$1
	local RELPATH=$(extract_dir ${FILE})
  local LONGPATH=$(expand_path ${RELPATH})
	local BASENAME=$(extract_basename ${FILE})
	local LONGFILEPATH=${LONGPATH}/${BASENAME}
  echo ${LONGFILEPATH}
}
#----------------------------------------------------------------------

######################################################################
# Multimedia
######################################################################

#----------------------------------------------------------------------
# Usage: is_image FILENAME
# Returns 0 if FILENAME is an image file, else 1.
#----------------------------------------------------------------------
is_image() {
  local FILE=$1
  identify ${FILE} > /dev/null 2>&1
  echo $?
}
#----------------------------------------------------------------------

######################################################################
# Miscellanous
######################################################################

#----------------------------------------------------------------------
# Usage: pad NUM WIDTH
# Returns a zero-padded string representation of NUM of width WIDTH.
#----------------------------------------------------------------------
pad() {
  local NUM=$1
  local WIDTH=$2
  printf %0${WIDTH}d ${NUM} 
}
#----------------------------------------------------------------------

