<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.dao.PRModel" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/home.css">

<title>Insert title here</title>

<%
//PRModel prmodel = new PRModel();
//prmodel.updateTodayProject();
%>

</head>
<body class="homepage">
<div id="page-wrapper">

    <!-- Header -->
    <div id="header-wrapper">
        <header id="header" class="container">

            <!-- Logo -->
            <div id="logo">
                <h1><a href="index.html">Gachon</a></h1>
                <span>Welcome to visit our site</span>
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
                <div class="7u 12u(medium)">
                    <h2>Hi. This is -Name-</h2>
                    <p>It's a free responsive site template by HTML5 UP</p>
                </div>
                <div class="5u 12u(medium)">

                    <ul>
                        <section class="loginform">
                            <form action="" method="get">
                                <div class="login_id">
                                    <label for="id">ID: </label>
                                    <input type="text" class="form-control txt" name="id" placeholder="　Enter id">
                                </div>
                                <div class="login_password">
                                    <label for="password">password: </label>
                                    <input type="password" class="form-control txt" name="password" placeholder="　Password">
                                </div>
                                <input type="submit" value="Login" formmethod="post" formaction="login.do">
                                <input type="submit" value="Signup" formmethod="get" formaction="join.do">
                                <!-- <a href="(% url 'signup' %)"><button>Signup</button></a> -->
                            </form>
                        </section>
                        <!--<li><a href="#" class="button big icon fa-arrow-circle-right">Join</a></li>
                        <li><a href="#" class="button alt big icon fa-question-circle">Login</a></li>-->
                    </ul>
                </div>

            </div>
        </div>
    </div>

    <!-- Features -->
    <div id="features-wrapper">
        <div class="container">
            <div class="row">
                <div class="4u 12u(medium)">

                    <!-- Box -->
                    <section class="box feature">
                        <a href="#" class="image featured"><img src="images/pic01.jpg" alt="" /></a>
                        <div class="inner">
                            <header>
                                <h2>Put something here</h2>
                                <p>Maybe here as well I think</p>
                            </header>
                            <p>Phasellus quam turpis, feugiat sit amet in, hendrerit in lectus. Praesent sed semper amet bibendum tristique fringilla.</p>
                        </div>
                    </section>

                </div>
                <div class="4u 12u(medium)">

                    <!-- Box -->
                    <section class="box feature">
                        <a href="#" class="image featured"><img src="images/pic02.jpg" alt="" /></a>
                        <div class="inner">
                            <header>
                                <h2>An interesting title</h2>
                                <p>This is also an interesting subtitle</p>
                            </header>
                            <p>Phasellus quam turpis, feugiat sit amet in, hendrerit in lectus. Praesent sed semper amet bibendum tristique fringilla.</p>
                        </div>
                    </section>

                </div>
                <div class="4u 12u(medium)">

                    <!-- Box -->
                    <section class="box feature">
                        <a href="#" class="image featured"><img src="images/pic03.jpg" alt="" /></a>
                        <div class="inner">
                            <header>
                                <h2>Oh, and finally ...</h2>
                                <p>Here's another intriguing subtitle</p>
                            </header>
                            <p>Phasellus quam turpis, feugiat sit amet in, hendrerit in lectus. Praesent sed semper amet bibendum tristique fringilla.</p>
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
</body>
</html>