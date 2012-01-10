EAPI=4

inherit autotools-utils bzr

DESCRIPTION="A greeter for LightDM that uses Webkit for theming"
HOMEPAGE="https://launchpad.net/lightdm-webkit-greeter"
EBZR_REPO_URI="lp:lightdm-webkit-greeter"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="nls static-libs"

RDEPEND="
	dev-libs/dbus-glib
	net-libs/webkit-gtk:2
	x11-libs/gtk+:2
	x11-misc/lightdm"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	nls? ( sys-devel/gettext )"

pkg_setup() {
	DOCS=(AUTHORS ChangeLog COPYING NEWS README)
}

src_prepare() {
	NOCONFIGURE=1 ./autogen.sh
}

src_install() {
	autotools-utils_src_install

	insinto /usr/share/xgreeters/
	doins "${FILESDIR}/lightdm-webkit-greeter.desktop"
}

