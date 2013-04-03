# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools-utils bzr

DESCRIPTION="Widgets and other objects used for indicators"
HOMEPAGE="https://launchpad.net/ido"
EBZR_REPO_URI="lp:ido"

LICENSE="LGPL-2.1 LGPL-3"
SLOT="3"
KEYWORDS=""
IUSE="doc static-libs"

RDEPEND="
	>=x11-libs/gtk+-3.1:3"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( dev-util/gtk-doc )"

pkg_setup() {
	DOCS=( AUTHORS COPYING COPYING.LGPL.2.1 ChangeLog NEWS README TODO )
}

src_prepare() {
	# Remove reference to ubuntu gtk+ patch
	sed -i 's/ubuntu_//' src/idoscalemenuitem.c

	# Remove GTK_DOC_CHECK if documentation is not enabled
	use doc || sed -i 's/GTK_DOC_CHECK(\[1.8\])//' configure.ac

	NOCONFIGURE=1 ./autogen.sh
}

