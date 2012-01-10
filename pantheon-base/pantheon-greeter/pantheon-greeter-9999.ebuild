EAPI=4

inherit bzr

DESCRIPTION="Pantheon Login Screen for the LightDM Webkit Greeter"
HOMEPAGE="https://launchpad.net/pantheon-greeter"
EBZR_REPO_URI="lp:pantheon-greeter"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	x11-misc/lightdm
	x11-misc/lightdm-webkit-greeter"
DEPEND=""

src_install() {
	insinto /usr/share/lightdm-webkit/themes/
	doins -r pantheon
}

