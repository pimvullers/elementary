# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3 cmake-utils vala gnome2-utils

VALA_MIN_API_VERSION=0.26

EGIT_REPO_URI="https://github.com/voldyman/MarkMyWords.git"

DESCRIPTION="A minimal markdown editor"
HOMEPAGE="https://github.com/voldyman/MarkMyWords"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="nls"

RDEPEND="
	dev-libs/glib:2
	|| ( net-libs/webkit-gtk:3 net-libs/webkit-gtk:4 )
	x11-libs/gtk+:3
	x11-libs/gtksourceview:3.0"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig"

src_prepare() {
	use nls || sed -i 's#add_subdirectory (po)##' CMakeLists.txt

	cmake-utils_src_prepare
	vala_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DGSETTINGS_COMPILE=OFF
		-DVALA_EXECUTABLE="${VALAC}"
	)

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
