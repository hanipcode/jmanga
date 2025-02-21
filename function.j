#########################Function#################################
#                                                                #
#        This file is the function file for jManga               #
#                                                                #
##################################################################

#*********************************************************************************#
#Function Name : Get Total Page                                                   #
#Used for      : Get a number of  pages from a chapter                            #                                                                                        #Parameter     : URL = the url of the first page                                  #
#                example: Chapter 21 of manga = mangafox/chapter1.html            #
#                         then that's the value you should input                  #
#Example       : getTotalPage "http://mangafox.me/manga/one_piece/v73/c722/1.html"#
#*********************************************************************************#
function getTotalPage() {
if [ -z "$1" ]
then
    echo "link for the first page not found!"
    exit $E_ARG_MISSING
fi
local tempPage=2
local page=1;
local fetchUrl=$(curl -s $1)
echo "fetchUrl: $1"
if [[ -z "$fetchUrl" ]]; then
    echo "Error: fetchUrl is empty!"
    exit 1
fi
while true; do
local getPageNumber=`echo $fetchUrl | awk -v i=$tempPage -F 'value' '{ print $i }'`
if [[ $getPageNumber == "" ]] ; then
  break;
fi
let "tempPage++"
let "page++"
done
let "page = (page-4)/2"
return $page
}

#*********************************************************************************#
#Function Name : Get Download                                                     #
#Used for      : Get the download link of a page                                  #                                                                                        #Parameter     : PAGE_URL = the url of the page                                   #
#                example: One piece page 1 = mangafox/op/c001/1.html              #
#                         then that's the value you should input                  #
#Example       : getDownload "http://mangafox.me/manga/one_piece/v73/c722/1.html" #
#*********************************************************************************#

function getDownload(){
if [ -z "$1" ]
then
  echo "Link not found!"
  exit $E_ARG_MISSING
fi
local renderPage=$(curl -s $1)
local getDownloadLink=`echo $renderPage | awk  -F 'img src="' '{ print $2 }'`;
local getDownloadLink2=`echo $getDownloadLink | cut -d'"' -f'1'`
echo "Extracted download link: '$getDownloadLink2'"
if [[ ${getDownloadLink2:0:1} == "/" ]]
then
  local getDownloadLink2=${getDownloadLink2:1}
fi
#return value
echo $getDownloadLink2
}

#*********************************************************************************#
#Function Name : Get Next Page                                                    #
#Used for      : Get link for next page                                           #                                                                                        #Parameter     : PAGE_URL = the url of the page                                   #
#                example: One piece page 1 = mangafox/op/c001/1.html              #
#                         then that's the value you should input                  #
#Example       : getNextPage "http://mangafox.me/manga/one_piece/v73/c722/1.html" #
#*********************************************************************************#

function getNextPage(){
  local currentPageLink=$1
  local next_page_number=$2
  local next_page=$(echo $currentPageLink | cut -d'/' -f1,2,3,4,5,6,7,8)
  local next_page+="/"
  local next_page+=$next_page_number".html"
  echo $next_page
}

#*********************************************************************************#
#Function Name : Get Next Chapter                                                 #
#Used for      : Get the link for next chapter                                    #                                                                                        #Parameter     : PAGE_URL = the url of the page                                   #
#                example: One piece page 1 = mangafox/op/c001/1.html              #
#                         then that's the value you should input                  #
#Example       : getDownload "http://mangafox.me/manga/one_piece/v73/c722/1.html" #
#*********************************************************************************#

function getNextChapter(){
  local currentChapter=$1
  local next_chapter_num=$2
  if(( $next_chapter_num < 10 )); then
    next_Chapter_Number="00"$next_chapter_num
  fi
  if(( $next_chapter_num >= 10 && $next_chapter_num < 100 )); then
    next_Chapter_Number="0"$next_chapter_num
  fi
  if(( $next_chapter_num >100 )); then
    next_Chapter_Number=$next_chapter_num
  fi
  local getNextChapter=`echo $currentChapter | cut -d'/' -f1,2,3,4,5,6,7`;
  local getNextChapter+="/c"$next_Chapter_Number"/1.html"
  echo $getNextChapter
}
