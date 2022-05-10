import 'dart:convert';


class Group {
	int? id;
	String? name;

	Group({
		this.id,
		this.name,
	});

	static List<String> campos = <String>[
		'ID', 
		'NAME', 
	];
	
	static List<String> colunas = <String>[
		'Id', 
		'Name', 
	];

	Group.fromJson(Map<String, dynamic> jsonDados) {
		id = jsonDados['id'];
		name = jsonDados['name'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonDados = Map<String, dynamic>();

		jsonDados['id'] = id ?? 0;
		jsonDados['name'] = name;
	
		return jsonDados;
	}
	

	String objetoEncodeJson(Group objeto) {
	  final jsonDados = objeto.toJson;
	  return json.encode(jsonDados);
	}
	
}