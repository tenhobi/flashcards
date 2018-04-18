import 'package:flashcards_common/src/data/data.dart';

class SectionData extends Data {
	final String name;
//	fixme: add exercises class
//	final List<String> materials;
//	final List<String> Excercises;

	SectionData(this.name);

	SectionData.fromMap(Map<String, dynamic> data)
			: name = data['name'];

	@override
	Map<String, dynamic> toMap() {
		return {
			'name': '$name',
		};
	}
}
