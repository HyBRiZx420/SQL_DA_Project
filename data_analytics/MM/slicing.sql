SELECT
	planet_id,
    star_id,
    spectral_type,
    (COUNT(DISTINCT spectral_type))
FROM values
GROUP BY planet_id, star_id, spectral_type;




SELECT
	DISTINCT s.spectral_type,
	         s.host_star_name,
	         s.star_id,
	         p.planet_id
FROM values AS v
JOIN stars AS s on s.star_id = v.star_id
JOIN planets AS p on s.star_id = p.star_id
ORDER BY spectral_type;


SELECT
	COUNT(sp)
	
	
FROM terrestrial_planets;
