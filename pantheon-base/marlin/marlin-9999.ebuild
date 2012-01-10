EAPI=4

inherit gnome2-utils cmake-utils bzr

DESCRIPTION="The sexiest fish in the large sea of file-browsers"
HOMEPAGE="https://launchpad.net/marlin"
EBZR_REPO_URI="lp:marlin"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	dev-db/sqlite:3
	dev-libs/dbus-glib
	>=dev-libs/glib-2.29.0:2
	x11-libs/granite
	dev-libs/libgee:0
	x11-libs/varka
	x11-libs/gtk+:3
	x11-libs/libnotify
	x11-libs/pango"
DEPEND="${RDEPEND}
	|| (
		dev-lang/vala:0.14
		dev-lang/vala:0.12
	)"

pkg_setup() {
	DOCS="AUTHORS COPYING ChangeLog NEWS README TODO"
}

src_prepare() {
	# Disable generation of Gtk+ icon cache, this is handled by this ebuild
	epatch "${FILESDIR}/${PN}-icons.patch"
}

src_configure() {
	local mycmakeargs=(
		-DGSETTINGS_COMPILE=OFF
		-DVALA_EXECUTABLE=$(type -p valac-0.14 valac-0.12 | head -n1)
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

