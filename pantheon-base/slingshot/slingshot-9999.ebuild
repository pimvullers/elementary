EAPI=4

inherit gnome2-utils cmake-utils bzr

DESCRIPTION="A lightweight app launcher for Elementary"
HOMEPAGE="https://launchpad.net/slingshot"
EBZR_REPO_URI="lp:slingshot"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	dev-libs/glib:2
	dev-libs/libgee:0
	dev-libs/libzeitgeist
	gnome-base/gnome-menus:0
	x11-libs/granite
	>=x11-libs/gtk+-3.2.0:3"
DEPEND="${RDEPEND}
	|| (
		dev-lang/vala:0.16
		dev-lang/vala:0.14
	)
	dev-util/pkgconfig"

pkg_setup() {
	DOCS=( AUTHORS COPYING README )
}

src_configure() {
	local mycmakeargs=(
		-DGSETTINGS_COMPILE=OFF
		-DICONCACHE_UPDATE=OFF
		-DVALA_EXECUTABLE=$(type -p valac-0.16 valac-0.14 | head -n1)
	)

	cmake-utils_src_configure
}

pkg_preinst() {
	gnome2_icon_savelist
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_icon_cache_update
	gnome2_schemas_update --uninstall
}

