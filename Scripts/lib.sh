# Sourced by other scripts, not to be run directly

# shared error codes
ERRONOTROOT=2
ERRGENERIC=3
ERRNOISO=4
ERRMOUNTFAILED=5

function fail() {
	echo ""
	if [ -n "$1" ]
	then 
		echo "ERROR: $1"
	else
		echo "ERROR: Essential command failed."
	fi
	echo ""

	if [ -n "$2" ]
	then
		exit $2
	else
		exit $ERRGENERIC
	fi
}

function require_root() {
	if [ $EUID != 0 ]
	then
		fail "ERROR: Must be run as root" $ERRNOTROOT
	fi
}

function basedir() {
# Defines the base working dir as the parent of wherever this script lives.
# Uses a symlink-aware technique for finding the directory, originally from:
#   http://stackoverflow.com/questions/59895/
	SOURCE="${BASH_SOURCE[0]}"
	while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
	  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
	  SOURCE="$(readlink "$SOURCE")"
	  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
	done
	echo "$( cd -P "$( dirname "$SOURCE" )" && pwd )/.."
}

function is_mounted() {
	mount | grep $(pwd)/$1		
}
