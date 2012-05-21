EAPI=4

inherit gnome2-utils cmake-utils bzr

DESCRIPTION="A development library for elementary development"
HOMEPAGE="https://launchpad.net/granite"
EBZR_REPO_URI="lp:granite"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="demo nls static-libs"

RDEPEND="
	dev-libs/glib:2
	>=dev-libs/gobject-introspection-0.9.12
	dev-libs/libgee:0
	>=x11-libs/gtk+-3.3.14:3"
DEPEND="${RDEPEND}
	dev-lang/vala:0.16
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

pkg_setup() {
	DOCS=( AUTHORS COPYING NEWS README )
}

src_prepare() {
	# Disable building of the demo application (if needed)
	use demo || sed -i 's/add_subdirectory(demo)//' CMakeLists.txt

	# Disable generation of the translations (if needed)
	use nls || sed -i 's/add_subdirectory (po)//' CMakeLists.txt
}

src_configure() {
	local mycmakeargs=(
		-DICON_UPDATE=OFF
		-DVALA_EXECUTABLE="$(type -p valac-0.16)"
		$(use static-libs && echo "-DBUILD_STATIC=Yes")
	)

	cmake-utils_src_configure
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}

