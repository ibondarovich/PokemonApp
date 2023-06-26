import 'package:core/core.dart';
import 'package:data/entity/pokemon_detailed_entity.dart';
import 'package:data/entity/pokemon_entity.dart';
import 'package:path/path.dart';
import 'local_provider.dart';

class SqlLiteProvider implements LocalProvider{
  Future<Database> initializeDB() async {
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

  @override
  Future<List<PokemonEntity>> getAll() async {
    final Database db = await initializeDB();
    final res = await db.query('Pokemons');
     final result = res.map((e) => 
         PokemonEntity.fromJson(e)).toList();
    return result;
  }

  @override
  Future<PokemonDetailedEntity> getOne() {
    // TODO: implement getOne
    throw UnimplementedError();
  }

  @override
  Future<void> saveAll(List<PokemonEntity> entities) async {
    int result = 0;
    final Database db = await initializeDB();
    final res = await db.query('Pokemons');
    if(res.isEmpty){
      //await db.delete('Pokemons');
      Map<String, dynamic> map = {};

      for (var val in entities) {
        Map<String, dynamic> entity = val.toMap();
        await db.insert('Pokemons', entity);
      }
      final res = await db.query('Pokemons');
      print(res.length);
      print(res);
    } 
  }
  
  @override
  Future<void> saveOne(PokemonEntity entity) {
    // TODO: implement saveOne
    throw UnimplementedError();
  }
}