import 'dart:convert';
import 'package:core/core.dart';
import 'package:data/data.dart';
import 'package:data/entity/pokemon_detailed_entity.dart';
import 'package:data/entity/pokemon_entity.dart';
import 'package:path/path.dart';
import 'local_provider.dart';

class SqlLiteProvider implements LocalProvider{
  Future<Database> initPokemons() async {
    String path = await getDatabasesPath();
    
    return openDatabase(
      join(path, 'database.db'),
      onCreate: (database, version) async {
         await database.execute( 
           """CREATE TABLE Pokemons(id INTEGER PRIMARY KEY AUTOINCREMENT, 
              name TEXT, url TEXT)""",
      );
     },
     version: 1,
    );
  }
   Future<Database> initDetailedPokemons() async {
    String path = await getDatabasesPath();
    
    return openDatabase(
      join(path, 'detailedPokemons.db'),
      onCreate: (database, version) async {
         await database.execute( 
           """CREATE TABLE DetailedPokemons(url TEXT PRIMARY KEY, 
              name TEXT, frontImg BLOB, weight INT, height INT, types TEXT)""",
      );
     },
     version: 1,
    );
  }

  @override
  Future<List<PokemonEntity>> getAll() async {
    final Database db = await initPokemons();
    final res = await db.query('Pokemons');
    final result = res.map((e) => 
         PokemonEntity.fromJson(e)).toList();
    return result;
  }

  @override
  Future<PokemonDetailedEntity> getOne(String url) async {
    final Database db = await initDetailedPokemons();
    final response =
        await db.query('detailedPokemons', where: 'url = ?', whereArgs: [url]);
    Map<String, Object?> temp ={};
    temp.addAll(response.first);
    temp['types'] = (temp['types'] as String).split('_');
    final result = PokemonDetailedEntity.fromJson(temp);
    return result;
  }

  @override
  Future<void> saveAll(List<PokemonEntity> entities) async {
    int result = 0;
    final Database db = await initPokemons();
    final res = await db.query('Pokemons');
    if(res.isEmpty){
      Map<String, dynamic> map = {};
      for (var val in entities) {
        Map<String, dynamic> entity = val.toMap();
        await db.insert('Pokemons', entity);
      }
      final res = await db.query('Pokemons');
    } 
  }
  
  @override
  Future<void> saveOne(PokemonDetailedEntity entity, String url) async {
    final Database db = await initDetailedPokemons();
    final res = await db.query('DetailedPokemons', where: 'url = ?', whereArgs: [url]);
    if(res.isEmpty){
      final Map<String, dynamic> json = {'url': url};
      json.addAll(entity.toJson());
      json['frontImg'] = json['frontImg'];
      json['types'] = (json['types'] as List).join('_');
      await db.insert('DetailedPokemons', json);
    } 
  }
}