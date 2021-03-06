-- FUNCTION
--Возвращает сколько видов вакцин производится в стране
CREATE OR REPLACE FUNCTION vaccines_in_country(smth text) RETURNS int AS
$$
  DECLARE
    resultat integer;
  BEGIN
    SELECT COUNT(*) INTO resultat
    FROM vaccines
    INNER JOIN origin_country ON vaccines.country_id = origin_country.country_id
    WHERE origin_country.country_name = smth;
    
   RETURN resultat;
  END;
$$ LANGUAGE 'plpgsql';

SELECT * FROM vaccines_in_country('USA')


-- PROCEDURE
-- ищет название вакцины по производителю
CREATE OR REPLACE PROCEDURE man_vaccine(manuf text)
LANGUAGE plpgsql AS
$$
  DECLARE
    nm record;
  BEGIN
    FOR nm IN
      SELECT vaccines.name
      FROM vaccines
      INNER JOIN manufacturer ON vaccines.mnf_id = manufacturer.mnf_id
      WHERE manufacturer.mnf_name = manuf
    LOOP
      RAISE INFO 'Vaccine is %', nm.name;
    END LOOP;
  END;
$$


CALL man_vaccine('Pfizer')


-- TRIGGER

CREATE OR REPLACE FUNCTION is_country() RETURNS trigger AS
$$
  DECLARE
  
  BEGIN
  	RAISE NOTICE 'NEW:%',NEW;
	NEW.country_name := 'Country is ' || NEW.country_name;
	return NEW;
	
  END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER country_updater
 BEFORE INSERT ON origin_country
 FOR EACH ROW EXECUTE FUNCTION is_country();
 
insert into origin_country( country_name)
	values('Moldova')
	returning *;
 
select * from origin_country
