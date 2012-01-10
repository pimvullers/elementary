EAPI=4

inherit cmake-utils bzr

DESCRIPTION="A development library for elementary development"
HOMEPAGE="https://launchpad.net/granite"
EBZR_REPO_URI="lp:granite"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="nls static-libs"

RDEPEND="
	dev-libs/glib:2
	x11-libs/gtk+:3
	>=dev-libs/gobject-introspection-0.9.12"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	|| (
		dev-lang/vala:0.14
		>=dev-lang/vala-0.12.0:0.12
	)
	nls? ( sys-devel/gettext )"

pkg_setup() {
	DOCS=( AUTHORS COPYING COPYRIGHT INSTALL NEWS README )
}

src_prepare() {
	# Disable building of the demo application
	sed -i 's/add_subdirectory(demo)//' CMakeLists.txt
}

src_configure() {
	local mycmakeargs=(
		-DVALA_EXECUTABLE="$(type -p valac-0.14 || type -p valac-0.12)"
		$(cmake-utils_use_build static-libs STATIC)
	)

	cmake-utils_src_configure
}

