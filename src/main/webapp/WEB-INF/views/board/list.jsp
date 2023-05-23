<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<script src="http://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<body>

<section class="notice">
  <div class="page-title">
        <div class="container">
            <h3>게시판</h3>
        </div>
    </div>

    <!-- board seach area -->
    <div id="board-search">
        <div class="container">
            <div class="search-window">
            	<div class="search-wrap">
	                <label for="title" class="blind">공지사항 내용 검색</label>
	                <input id="title" type="search" name="" placeholder="검색어를 입력해주세요." value="" onkeyup="if(window.event.keyCode==13){searchList()}">
	                <button onclick="searchList()" class="btn btn-dark">검색</button>
            	</div>
            </div>
        </div>
    </div>
   
  <!-- board list area -->
    <div id="board-list">
        <div class="container">
            <table class="board-table">
                <thead>
                <tr>
<!--                     <th scope="col" class="th-num">순번</th> -->
                    <th scope="col" class="th-title">제목</th>
                    <th scope="col" class="th-date">작성자</th>
                    <th scope="col" class="th-date">등록일</th>
                    <th scope="col" class="th-date">조회수</th>
                </tr>
                </thead>
                <tbody id="tbody">
                </tbody>
            </table>
             <input type="button" class="btn btn-dark" style="width: 80px; height: 30px; margin-top: 20px; float:right;" onclick="boardWrite();" value="등록"/>
        </div>
    </div>
</section>
</body>

<script type="text/javascript">

window.onload = () => {
	findAll();	
}


let html = '';

/**
 * 게시글 리스트 조회
 */
function findAll() {
	fetch('/api/boards').then(response => {
		if (response.ok) {
 			return response.json();
		}
	}).then(json => {
		if (!json.length) {
			html = '<td colspan="4">등록된 게시글이 없습니다.</td>';
		} else {
			json.forEach((obj, idx) => {
				
				html += "<tr>" +
//   						"<td>"+(parseInt(idx)+1)+"</td>" + 
  						"<td class=\"text-left\">" +
  							"<a href=\"javascript: void(0);\" onclick=\"goView("+obj.id+")\">"+obj.title+"</a>" +
  						"</td>" +
  						"<td>"+obj.writer+"</td>" +
  						"<td>"+obj.createdDate+"</td>" +
  						"<td>"+obj.hits+"</td>" +
					"</tr>";
			});
		}

		document.getElementById('tbody').innerHTML = html;
	});
}

/**
 * 게시글 조회
 */
function goView(id) {
	location.href = "/board/view/" + id;
}
	
/**
 * 게시글 검색
 */
function searchList() {

	html = "";
	$.ajax({
	    url: "/api/boards", 
	    data : {
	    	title : $('#title').val()
	    },
	    method: "GET",   
	    dataType: "json" 
	})
	.done(function(json) {
		json.forEach((obj, idx) => {
			
			html += "<tr>" +
						"<td>"+(parseInt(idx)+1)+"</td>" + 
						"<td class=\"text-left\">" +
							"<a href=\"javascript: void(0);\" onclick=\"goView("+obj.id+")\">"+obj.title+"</a>" +
						"</td>" +
						"<td>"+obj.writer+"</td>" +
						"<td>"+obj.createdDate+"</td>" +
						"<td>"+obj.hits+"</td>" +
				"</tr>";

		});
		document.getElementById('tbody').innerHTML = html;
	})
}

function boardWrite() {
	location.href = "/board/write";
}
</script>

<style>
	table {
	  border-collapse: collapse;
	  border-spacing: 0;
	}
	section.notice {
	  padding: 80px 0;
	}
	
	.page-title {
	  margin-bottom: 60px;
	}
	.page-title h3 {
	  font-size: 28px;
	  color: #333333;
	  font-weight: 400;
	  text-align: center;
	}
	
	#board-search .search-window {
	  padding: 15px 0;
	  background-color: #f9f7f9;
	}
	#board-search .search-window .search-wrap {
	  position: relative;
	/*   padding-right: 124px; */
	  margin: 0 auto;
	  width: 80%;
	  max-width: 564px;
	}
	#board-search .search-window .search-wrap input {
	  height: 40px;
	  width: 100%;
	  font-size: 14px;
	  padding: 7px 14px;
	  border: 1px solid #ccc;
	}
	#board-search .search-window .search-wrap input:focus {
	  border-color: #333;
	  outline: 0;
	  border-width: 1px;
	}
	#board-search .search-window .search-wrap .btn {
	  position: absolute;
	  right: 0;
	  top: 0;
	  bottom: 0;
	  width: 108px;
	  padding: 0;
	  font-size: 16px;
	}
	
	.board-table {
	  font-size: 13px;
	  width: 100%;
	  border-top: 1px solid #ccc;
	  border-bottom: 1px solid #ccc;
	}
	
	.board-table a {
	  color: #333;
	  display: inline-block;
	  line-height: 1.4;
	  word-break: break-all;
	  vertical-align: middle;
	}
	.board-table a:hover {
	  text-decoration: underline;
	}
	.board-table th {
	  text-align: center;
	}
	
	.board-table .th-num {
	  width: 100px;
	  text-align: center;
	}
	
	.board-table .th-date {
	  width: 200px;
	}
	
	.board-table th, .board-table td {
	  padding: 14px 0;
	}
	
	.board-table tbody td {
	  border-top: 1px solid #e7e7e7;
	  text-align: center;
	}
	
	.board-table tbody th {
	  padding-left: 28px;
	  padding-right: 14px;
	  border-top: 1px solid #e7e7e7;
	  text-align: left;
	}
	
	.board-table tbody th p{
	  display: none;
	}
	
	.btn {
	  display: inline-block;
	  font-size: 15px;
	  font-weight: 400;
	  background: transparent;
	  text-align: center;
	  white-space: nowrap;
	  vertical-align: middle;
	  -ms-touch-action: manipulation;
	  touch-action: manipulation;
	  cursor: pointer;
	  -webkit-user-select: none;
	  -moz-user-select: none;
	  -ms-user-select: none;
	  user-select: none;
	  border: 1px solid transparent;
	  text-transform: uppercase;
	  -webkit-border-radius: 0;
	  -moz-border-radius: 0;
	  border-radius: 0;
	  -webkit-transition: all 0.3s;
	  -moz-transition: all 0.3s;
	  -ms-transition: all 0.3s;
	  -o-transition: all 0.3s;
	  transition: all 0.3s;
	}
	
	.btn-dark {
	  background: #555;
	  color: #fff;
	}
	
	.btn-dark:hover, .btn-dark:focus {
	  background: #373737;
	  border-color: #373737;
	  color: #fff;
	}
	
	.btn-dark {
	  background: #555;
	  color: #fff;
	}
	
	.btn-dark:hover, .btn-dark:focus {
	  background: #373737;
	  border-color: #373737;
	  color: #fff;
	}
	
	/* reset */
	
	* {
	  list-style: none;
	  text-decoration: none;
	  padding: 0;
	  margin: 0;
	  box-sizing: border-box;
	}
	.clearfix:after {
	  content: '';
	  display: block;
	  clear: both;
	}
	.container {
	  width: 1100px;
	  margin: 0 auto;
	}
	.blind {
	  position: absolute;
	  overflow: hidden;
	  clip: rect(0 0 0 0);
	  margin: -1px;
	  width: 1px;
	  height: 1px;
	}
</style>
</html>