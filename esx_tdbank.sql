USE `essentialmode`;

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_banker','TD Bank',1),
	('bank_savings','Placements',0)
;

INSERT INTO `jobs` (name, label) VALUES
	('banker','Banque TD')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('banker',0,'advisor','Caissier',0,'{}','{}'),
	('banker',1,'banker','Conseiller',0,'{}','{}'),
	('banker',2,'director',"Directeur",0,'{}','{}'),
	('banker',3,'drm','DRM',0,'{}','{}'),
	('banker',4,'vp','VP',0,'{}','{}'),
	('banker',5,'boss','PDG',0,'{}','{}')
;