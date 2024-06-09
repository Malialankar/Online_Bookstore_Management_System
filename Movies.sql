create database studio;

set SQL_safe_updates = 0;

use studio;

create table movies (id int primary key, title varchar(50), director varchar(50), Year int , length_min int);

insert into movies values(1, "Toy Story", "john Lasseter", 1995,81);

insert into movies values(2, "A Bug's Life", "john Lasseter",  1998, 95),
(3, "Toy Story 2", "john Lasseter",  1999, 93),
(4, "Monsters", "Pete Docter",  2001, 92);

insert into movies values
(5,"Finding nemo", "Andre stanton", 2003, 107),
(6, "The Incredibles"," Brad Bird", 2004, 116),
(7,"cars", "john Lasseter", 2006, 117),
(8, "ratatoullie", "Brad Bird", 2007,115),
(9, "Wall-E"," Andrew Stantion", 2008, 104),
(10,"UP","Pete Dictor", 2009,101);

update movies set director = " Andrew Stantion"where id=5 ; 

update movies set director = "Pete Dictor" where id=4 ; 


select * from movies;

select count(director) from movies;

select distinct title, director from movies group by director order by id;

select distinct title, director from movies group by title order by id;

select*, row_number() over( partition by director) as movie from movies group by year;


--  BOX_OFFICE TABLE CREATED---------------------------------------------------------------------------------------------------------------
create table boxoffice( movie_id int primary key, rating float, Domestic_sales decimal(10,0), International_sales decimal(10,0),
id int, 
foreign key (id) references movies(id))
;

 alter table boxoffice modify column rating decimal(10,2);
 
alter table boxoffice modify column Domestic_sales decimal(12,0);  
 
alter table boxoffice modify  column International_sales decimal(12,0);
 
 describe boxoffice;
 
insert into boxoffice values
(5, 8.2, 380843261, 55590000,1),
(14, 7.4, 268492764, 475066843,3),
(8, 8, 206445654, 417277164,3),
(12, 6.4, 191452396,368400000,6),
(3, 7.9,245852179, 239163000,2),
(6, 8, 261441092, 370001000,5),
(9, 8.5, 223808164,297503696,8),
(11, 8.4, 415004880,648167031,9),
(1, 8.3, 191796233, 17016503,3),
(7, 7.2, 244082982, 217900167,1),
(10, 8.3, 293004164, 438338580,4),
(4, 8.1, 289916256, 272900000,7),
(2, 7.2, 162798565, 200600000,10),
(13, 7.2, 237283207, 301700000,6);

select * from boxoffice;

select title, Domestic_Sales, International_sales from Movies join boxoffice on movies.id=boxoffice.id;  -- internalal and domestic sales of each movie

-- internation sale > domestic sale
select title, Domestic_Sales, International_sales from Movies join boxoffice on movies.id=boxoffice.id where international_Sales > domestic_sales;

-- list of movies based on rating 
select movies.id , boxoffice.id, title, rating from movies join boxoffice on movies.id= boxoffice.id order by rating desc;

select movies.id , boxoffice.movie_id,title, rating from movies join boxoffice on movies.id= boxoffice.movie_id order by rating desc;

select * from boxoffice;

select * from boxoffice where rating between 7.5 and 8.5 order by rating; -- show record within the range based the values we have set
select * from boxoffice where rating in (7.2 , 8.5) order by rating;  -- show record based on the values that we have set
-- like opreator
select * from movies where title like"t%"; -- Movie starts from T
select * from movies where title like"t%s"; -- Movie starts from T and from s
select * from movies where title like"_t%"; -- Movie letter T comes on 2nd position

select count(distinct title) from movies;

select title from movies where title is not null;

select *, max(year) over(partition by director ) as year from movies order by year;

select *, row_number() over(partition by director ) as rn from movies order by year;

select *, rank() over(partition by director order by year desc) as rn from movies;

select *, dense_rank() over(partition by director order by year desc) as rn from movies;

select *, max(length_min) over(partition by title ) as movies_length from movies order by length_min desc;

select * from (
select *, max(length_min) over(partition by title ) as movies_length from movies order by length_min desc
) as long_movie
where long_movie.movies_length > 100;
