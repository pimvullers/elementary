# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit cmake-utils bzr

DESCRIPTION="Use PackageKit and SQLHeavy to build a fast distro agnostic applications store."
HOMEPAGE="https://launchpad.net/libappstore"
EBZR_REPO_URI="lp:libappstore"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="gtk"

RDEPEND="
	app-admin/packagekit-base
	dev-db/sqlheavy:0.1
	dev-libs/glib:2
	dev-libs/libgee:0
	gtk? ( >=x11-libs/gtk+-3.3.14:3 )"
DEPEND="${RDEPEND}
	dev-lang/vala:0.18
	virtual/pkgconfig"

pkg_setup() {
	DOCS=( AUTHORS COPYING NEWS README )
}

src_prepare() {
	epatch "${FILESDIR}/${PN}-0.1-optional-gtk.patch"

	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_disable gtk GTK)
		$(cmake-utils_use_want gtk GTK)
		-DVALA_EXECUTABLE="$(type -p valac-0.18)"
	)

	cmake-utils_src_configure
}
