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
