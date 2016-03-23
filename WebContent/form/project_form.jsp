<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!--
	Verti by HTML5 UP
	html5up.net | @n33co
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
 -->
        <title>Verti by HTML5 UP</title>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
        <link rel="stylesheet" type="text/css" href="./css/main.css" />
        <link rel="stylesheet" type="text/css" href="./css/addcss.css" />
        <script src="./js/jquery.min.js"></script>
        <script src="./js/jquery.dropotron.min.js"></script>
        <script src="./js/skel.min.js"></script>
        <script src="./js/util.js"></script>
        <!--[if lte IE 8]><script src="assets/js/ie/respond.min.js"></script><![endif]-->
        <script src="./js/main.js"></script>
        <!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js" type="text/javascript"></script>
        
        <script type="text/javascript">
            function addRow(TableID) // 테이블 동적 생성
            {
            }
            $(document).ready(function(){
                              // 옵션추가 버튼 클릭시
                              $("#addItemBtn").click(function(){
                                                     // item 의 최대번호 구하기
                                                     var lastItemNo = $("#tableid tr:last").attr("class").replace("item", "");
                                                     
                                                     var newitem = $("#tableid tr:eq(1)").clone();
                                                     newitem.removeClass();
                                                     newitem.find("td:eq(0)").attr("rowspan", "1");
                                                     newitem.addClass("item"+(parseInt(lastItemNo)+1));
                                                     
                                                     $("#tableid").append(newitem);
                                                     });
                              
                              
                              // 항목추가 버튼 클릭시
                              $(".addBtn").live("click", function(){
                                                var clickedRow = $(this).parent().parent();
                                                var cls = clickedRow.attr("class");
                                                
                                                // tr 복사해서 마지막에 추가
                                                var newrow = clickedRow.clone();
                                                newrow.find("td:eq(0)").remove();
                                                newrow.insertAfter($("#tableid ."+cls+":last"));
                                                
                                                // rowspan 조정
                                                resizeRowspan(cls);
                                                });
                              
                              
                              // 삭제버튼 클릭시
                              $(".delBtn").live("click", function(){
                                                var clickedRow = $(this).parent().parent();
                                                var cls = clickedRow.attr("class");
                                                
                                                // 각 항목의 첫번째 row를 삭제한 경우 다음 row에 td 하나를 추가해 준다.
                                                if( clickedRow.find("td:eq(0)").attr("rowspan") ){
                                                if( clickedRow.next().hasClass(cls) ){
                                                clickedRow.next().prepend(clickedRow.find("td:eq(0)"));
                                                }
                                                }
                                                
                                                clickedRow.remove();
                                                
                                                // rowspan 조정
                                                resizeRowspan(cls);
                                                });
                              
                              // cls : rowspan 을 조정할 class ex) item1, item2, ...
                              function resizeRowspan(cls){
                              var rowspan = $("."+cls).length;
                              $("."+cls+":first td:eq(0)").attr("rowspan", rowspan);
                              }
                              });
            </script>
    </head>
    <body class="homepage">
        <div id="page-wrapper">
            
            <!-- Header -->
            <div id="header-wrapper">
                <header id="header" class="container">
                    
                    <!-- Logo -->
                    <div id="logo">
                        <h1><a href="index.html">Puzzling</a></h1>
                        <span>Gachon Software</span>
                    </div>
                    
                    <!-- Nav -->
                    <nav id="nav">
                        <ul>
                            <li class="current"><a href="index.html">Welcome</a></li>
                            <li>
                                <a href="#">Dropdown</a>
                                <ul>
                                    <li><a href="#">Lorem ipsum dolor</a></li>
                                    <li><a href="#">Magna phasellus</a></li>
                                    <li>
                                        <a href="#">Phasellus consequat</a>
                                        <ul>
                                            <li><a href="#">Lorem ipsum dolor</a></li>
                                            <li><a href="#">Phasellus consequat</a></li>
                                            <li><a href="#">Magna phasellus</a></li>
                                            <li><a href="#">Etiam dolore nisl</a></li>
                                        </ul>
                                    </li>
                                    <li><a href="#">Veroeros feugiat</a></li>
                                </ul>
                            </li>
                            <li><a href="left-sidebar.html">Left Sidebar</a></li>
                            <li><a href="right-sidebar.html">Right Sidebar</a></li>
                            <li><a href="no-sidebar.html">No Sidebar</a></li>
                        </ul>
                    </nav>
                    
                </header>
            </div>
            
            <!-- Banner -->
            <div id="banner-wrapper">
                <div id="banner" class="box container">
                    <div class="row">
                        
                        <div style="width: 900px; height:380px;" class="container"  text-center>
                            <div>
                                <header>
                                    <h2 style="text-align:center;">Project Name</h2>
                                </header>
                            </div>
                            
                            <div id="current_prj">
                                <table id="tableid" width="100%" cellspacing="0" cellpadding="0" align="middle">
                                    <tr>
                                        <th colspan="2">등록된 클래스 목록</th>
                                        
                                    </tr>
                                    <tr class="item1">
                                        <td>Class name</td>
                                        
                                        <td style="width:15%;">
                                            <button id="edit" class="delBtn">참여</button>
                                        </td>
                                    </tr>

                                </table>
                                <button id="addItemBtn">클래스추가</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Features -->
            <div id="features-wrapper">
                <div class="container">
                    <div class="row">
                        <div class="4u 12u(medium)" style="width:490px;">
                            
                            <!-- Box -->
                            <section class="box feature">
                                <div style="height:380px;" class="container" text-center>
                                    <div class="inner">
                                        <header>
                                            <h2>Issue Tracker</h2>
                                        </header>
                                        <table id="tableid" width="100%" cellspacing="0" cellpadding="0" align="middle">
                                            <tr class="item1">
                                                
                                                <td><input type="text" name="member_name"></td>
                                            </tr>
                                            <tr class="item1">
                                                
                                                <td><input type="text" name="member_name"></td>
                                            </tr>
                                            
                                        </table>

                                    </div>
                                    
                                </div>
                            </section>
                            
                        </div>
                        <div class="4u 12u(medium)" style="width:490px;">
                            
                            <!-- Box -->
                            <section class="box feature" style="background-color: #f0fff0;">
                                <div style="height:380px;" class="container" text-center>
                                    <div class="inner">
                                        <header>
                                            <h2>Board</h2>
                                        </header>
                                    </div>
                                    <div id="board">
                                        <table style="border:1px;" width="100%" cellspacing="0" cellpadding="0" align="middle">
                                            <tr style="width:382px;">
                                                <th colspan="2"><input type="text" align="center" style="width:80%";>
                                                <button id="addPostBtn" style="width:60px; height:40px text-align:left; font-size:10px;">Post</button></th>
                                                
                                            </tr>
                                            <tr class="item1">
                                                <!--
                                                <td>Class name</td>
                                                
                                                <td style="width:75%;">
                                                    설명
                                                </td>
                                                 -->
                                            </tr>
                                            
                                        </table>
                                        

                                    </div>
                                    
                                </div>
                            </section>
                            
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Main -->
            <div id="main-wrapper">
                <div class="container">
                    <div class="row 200%">
                        <div class="4u 12u(medium)">
                            
                            <!-- Sidebar -->
                            <div id="sidebar">
                                <section class="widget thumbnails">
                                    <h3>Interesting stuff</h3>
                                    <div class="grid">
                                        <div class="row 50%">
                                            <div class="6u"><a href="#" class="image fit"><img src="images/pic04.jpg" alt="" /></a></div>
                                            <div class="6u"><a href="#" class="image fit"><img src="images/pic05.jpg" alt="" /></a></div>
                                            <div class="6u"><a href="#" class="image fit"><img src="images/pic06.jpg" alt="" /></a></div>
                                            <div class="6u"><a href="#" class="image fit"><img src="images/pic07.jpg" alt="" /></a></div>
                                        </div>
                                    </div>
                                    <a href="#" class="button icon fa-file-text-o">More</a>
                                </section>
                            </div>
                            
                        </div>
                        <div class="8u 12u(medium) important(medium)">
                            
                            <!-- Content -->
                            <div id="content">
                                <section class="last">
                                    <h2>So what's this all about?</h2>
                                    <p>This is <strong>Verti</strong>, a free and fully responsive HTML5 site template by <a href="http://html5up.net">HTML5 UP</a>.
                                    Verti is released under the <a href="http://html5up.net/license">Creative Commons Attribution license</a>, so feel free to use it for any personal or commercial project you might have going on (just don't forget to credit us for the design!)</p>
                                    <p>Phasellus quam turpis, feugiat sit amet ornare in, hendrerit in lectus. Praesent semper bibendum ipsum, et tristique augue fringilla eu. Vivamus id risus vel dolor auctor euismod quis eget mi. Etiam eu ante risus. Aliquam erat volutpat. Aliquam luctus mattis lectus sit amet phasellus quam turpis.</p>
                                    <a href="#" class="button icon fa-arrow-circle-right">Continue Reading</a>
                                </section>
                            </div>
                            
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Footer -->
            <div id="footer-wrapper">
                <footer id="footer" class="container">
                    <div class="row">
                        <div class="3u 6u(medium) 12u$(small)">
                            
                            <!-- Links -->
                            <section class="widget links">
                                <h3>Random Stuff</h3>
                                <ul class="style2">
                                    <li><a href="#">Etiam feugiat condimentum</a></li>
                                    <li><a href="#">Aliquam imperdiet suscipit odio</a></li>
                                    <li><a href="#">Sed porttitor cras in erat nec</a></li>
                                    <li><a href="#">Felis varius pellentesque potenti</a></li>
                                    <li><a href="#">Nullam scelerisque blandit leo</a></li>
                                </ul>
                            </section>
                            
                        </div>
                        <div class="3u 6u$(medium) 12u$(small)">
                            
                            <!-- Links -->
                            <section class="widget links">
                                <h3>Random Stuff</h3>
                                <ul class="style2">
                                    <li><a href="#">Etiam feugiat condimentum</a></li>
                                    <li><a href="#">Aliquam imperdiet suscipit odio</a></li>
                                    <li><a href="#">Sed porttitor cras in erat nec</a></li>
                                    <li><a href="#">Felis varius pellentesque potenti</a></li>
                                    <li><a href="#">Nullam scelerisque blandit leo</a></li>
                                </ul>
                            </section>
                            
                        </div>
                        <div class="3u 6u(medium) 12u$(small)">
                            
                            <!-- Links -->
                            <section class="widget links">
                                <h3>Random Stuff</h3>
                                <ul class="style2">
                                    <li><a href="#">Etiam feugiat condimentum</a></li>
                                    <li><a href="#">Aliquam imperdiet suscipit odio</a></li>
                                    <li><a href="#">Sed porttitor cras in erat nec</a></li>
                                    <li><a href="#">Felis varius pellentesque potenti</a></li>
                                    <li><a href="#">Nullam scelerisque blandit leo</a></li>
                                </ul>
                            </section>
                            
                        </div>
                        <div class="3u 6u$(medium) 12u$(small)">
                            
                            <!-- Contact -->
                            <section class="widget contact last">
                                <h3>Contact Us</h3>
                                <ul>
                                    <li><a href="#" class="icon fa-twitter"><span class="label">Twitter</span></a></li>
                                    <li><a href="#" class="icon fa-facebook"><span class="label">Facebook</span></a></li>
                                    <li><a href="#" class="icon fa-instagram"><span class="label">Instagram</span></a></li>
                                    <li><a href="#" class="icon fa-dribbble"><span class="label">Dribbble</span></a></li>
                                    <li><a href="#" class="icon fa-pinterest"><span class="label">Pinterest</span></a></li>
                                </ul>
                                <p>1234 Fictional Road<br />
                                Nashville, TN 00000<br />
                                (800) 555-0000</p>
                            </section>
                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="12u">
                            <div id="copyright">
                                <ul class="menu">
                                    <li>&copy; Untitled. All rights reserved</li><li>Design: <a href="http://html5up.net">HTML5 UP</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </footer>
            </div>
            
        </div>
        
        
        
        <!-- Scripts -->
        
        
        
    </body>
</html>