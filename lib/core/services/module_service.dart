import 'package:edukasi_pot/core/services/api/api.dart';
import 'package:edukasi_pot/core/services/api/models.dart';
import 'package:edukasi_pot/core/services/stoppable_service.dart';
import 'package:edukasi_pot/locator.dart';

class ModuleService implements StoppableService{
  Api _api = locator<Api>();

  List<Module> _modules;
  List<Module> get modules => _modules;

  Future getModules(String subjectId) async {
    _modules = await _api.getModulesForSubject(subjectId);
  }

  int _selectedModule = 1;
  int get moduleIndex => _selectedModule;

  void setActiveModule(int index) {
    _selectedModule = index;
  }

  @override
  bool get serviceStopped => null;

  @override
  void start() {
  }

  @override
  void stop() {
  }
}
