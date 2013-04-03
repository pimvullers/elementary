EAPI=5

VALA_MIN_API_VERSION=0.14

inherit vala cmake-utils

DESCRIPTION="A development library for elementary development"
HOMEPAGE="https://launchpad.net/granite"
SRC_URI="https://launchpad.net/${PN}/0.x/0.1/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="demo nls static-libs"

RDEPEND="
	dev-libs/glib:2
	>=dev-libs/gobject-introspection-0.9.12
	dev-libs/libgee:0
	<x11-libs/gtk+-3.5:3"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

pkg_setup() {
	DOCS=( AUTHORS COPYING NEWS README )
}

src_prepare() {
	# Disable building of the demo application (if needed)
	use demo || sed -i 's/add_subdirectory(demo)//' CMakeLists.txt

	# Disable generation of the translations (if needed)
	use nls || sed -i 's/add_subdirectory (po)//' CMakeLists.txt

	cmake-utils_src_prepare
	vala_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DVALA_EXECUTABLE="${VALAC}"
		$(use static-libs && echo "-DBUILD_STATIC=Yes")
	)

	cmake-utils_src_configure
}

