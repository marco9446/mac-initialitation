from subprocess import call

class Program(object):
    """

    """
    installers_linux = ['apt', 'umake', 'pip', 'npm']
    installers_osx = ['brew', 'brewcask', 'pip', 'npm']


    def __init__(self, obj, platform):
        self.platform = platform
        self.name = obj['name']
        self.os = obj['os']
        self.installers = obj['installers']
        self.configurator = obj.get('configurator')
        self.brew_name = obj.get('brew_name')
        self.apt_name = obj.get('apt_name')
        self.pip_npm_name = obj.get('pip_npm_name')
        self.confirm_installation = obj.get('confirm_installation')
        self.shell = obj.get('shell', {})

        self.installer = None
        self.moduleName = None


    def _askPermission(self):
        needConfirmation = True
        if self.confirm_installation == False:
            needConfirmation = False

        if needConfirmation:
            print('{}Do you want to install {}? Y/n{}'.format(
                '\033[92m', self.name, '\033[0m'))
            yes = set(['yes', 'y', 'ye', ''])
            no = set(['no', 'n'])

            choice = input().lower()
            if choice in yes:
                return True
            elif choice in no:
                return False
            else:
                sys.stdout.write("Please respond with 'yes' or 'no'")
        else:
            return True

    def _defineInstaller(self):
        installer = []
        if (self.platform == 'Osx'):
            installer = list(
                set(self.installers).intersection(Program.installers_osx))
        elif (self.platform == 'Linux'):
            installer = list(
                set(self.installers).intersection(Program.installers_linux))

        self.installer = installer[0]

    def _defineModuleName(self):
        self.moduleName = self.name
        if (self.platform == 'Osx' and self.brew_name != None):
            self.moduleName = self.brew_name
        elif (self.platform == 'Linux' and self.apt_name != None):
            self.moduleName = self.apt_name
        if ((self.installer == 'pip' or self.installer == 'npm') and self.pip_npm_name != None):
            self.moduleName = self.pip_npm_name

    def _runPreinstalation(self):
        if (self.shell != {}):
            if self.platform in self.shell['os']:
                comm = self.shell['command'].split()
                call(comm)

    def _runPostInstallation(self):
        if (self.configurator != None):
            call(self.configurator, shell=True)


    def installModule(self):
        if ( not self._askPermission()):
            return

        self._defineInstaller()
        self._defineModuleName()
        self._runPreinstalation()

        name = self.moduleName.split()
        if (self.installer == 'brew'):
            call(["brew", "install"] + name)
        elif (self.installer == 'brewcask'):
            call(["brew", "cask", "install"] + name)
        elif (self.installer == 'apt'):
            call(['sudo', 'apt', '-y', 'install'] + name)
        elif (self.installer == 'umake'):
            call(["umake"] + name)
        elif (self.installer == 'pip'):
            call(["pip3", "install"] + name)
        elif (self.installer == 'npm'):
            call(["sudo", "npm", "install", "-g"] + name)
        else:
            print("Installer '{}' doesn't exist".format(self.installer))

        self._runPostInstallation()